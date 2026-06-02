image_name := env("BUILD_IMAGE_NAME", "apollo")
image := env("IMAGE_FULL", "apollo:latest")
image_tag := env("BUILD_IMAGE_TAG", "latest")
base_dir := env("BUILD_BASE_DIR", ".")
filesystem := env("BUILD_FILESYSTEM", "ext4")
build_args := env("BUILD_ARGUMENTS", "")
just := just_executable()
container_runtime := env("CONTAINER_RUNTIME", `command -v podman >/dev/null 2>&1 && echo podman || echo docker`)
profiles := env("BUILD_PROFILES", "")

[private]
default:
    @{{ just }} --list

alias build := build-bootc
alias i := interactive-build

[script]
interactive-build:
    selected=$(ls mkosi.profiles | fzf -m --header="Press tab to select profiles to include in build")
    profiles=$(echo "$selected" | tr '\n' ' ' | sed 's/ $//')
    {{ just }} build-bootc "$profiles"

build-bootc $profiles=profiles:
    #!/bin/bash

    for profile in {{profiles}}; do
        args="$args --profile $profile"
    done

    mkosi -B --debug --profile=bootc ${args}

lint:
    podman run --rm -it --entrypoint=bootc {{image}} container lint

load:
    #!/usr/bin/env bash
    set -x
    podman load -i "$(find mkosi.output/* -maxdepth 0 -type d -printf "%T@ ,%p\n" -iname "_*" -print0 | sort -n | head -n1 | cut -d, -f2)" -q | cut -d: -f3 | xargs -I{} podman tag {} {{image}}

bootc *ARGS:
    #!/usr/bin/env bash
    set -eoux pipefail

    BOOTC_INSTALL_OPTIONS=()
    BOOTC_INSTALL_OPTIONS+=("-v" "/var/lib/containers:/var/lib/containers" "-v" "/etc/containers:/etc/containers")

    if [[ -d /sys/fs/selinux ]]; then
      BOOTC_INSTALL_OPTIONS+=("-v" "/sys/fs/selinux:/sys/fs/selinux" "--security-opt" "label=type:unconfined_t")
    fi

    podman run \
        --rm --privileged --pid=host \
        -it \
        "${BOOTC_INSTALL_OPTIONS[@]}" \
        -v /dev:/dev \
        -v "${BUILD_BASE_DIR:-.}:/data" \
        {{image}} bootc {{ ARGS }}

# Generate a bootable .img file with Apollo installed
generate-bootable-image $base_dir=base_dir $filesystem=filesystem:
    #!/usr/bin/env bash
    if [ ! -e "${base_dir}/bootable.img" ] ; then
        fallocate -l 20G "${base_dir}/bootable.img"
    fi
    just bootc install to-disk --composefs-backend --via-loopback /data/bootable.img --filesystem "${filesystem}" --wipe --bootloader systemd

# Fix "cannot apply additional memory protection after relocation" errors building the image on systems with SELinux. 
fix-selinux-container-permissions:
    #!/usr/bin/env bash
    sudo restorecon -RFv /var/lib/containers/storage

# Run a shell in the container
run-shell *ARGS:
    sudo podman run \
        --rm --privileged --pid=host \
        -it \
        -v /sys/fs/selinux:/sys/fs/selinux \
        -v /etc/containers:/etc/containers:Z \
        -v /var/lib/containers:/var/lib/containers:Z \
        -v /dev:/dev \
        -e RUST_LOG=debug \
        -v "{{base_dir}}:/data" \
        --security-opt label=type:unconfined_t \
        "{{image}}" bash

# Rechunk the final Apollo image with Chunkah
rechunk: 
    #!/bin/bash
    IMG="{{image}}"
    export CHUNKAH_CONFIG_STR="$(podman inspect $IMG)"
    podman run --rm --mount=type=image,src=$IMG,dest=/chunkah \
        -e CHUNKAH_CONFIG_STR quay.io/coreos/chunkah build \
        --label containers.bootc=1 \
        --compressed --max-layers 128 \
        -t $IMG | podman load

clean:
    mkosi clean
    sudo rm -r mkosi.tools/ mkosi.cache/
