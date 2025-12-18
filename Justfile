image_name := env("BUILD_IMAGE_NAME", "apollo")
image_tag := env("BUILD_IMAGE_TAG", "latest")
base_dir := env("BUILD_BASE_DIR", ".")
filesystem := env("BUILD_FILESYSTEM", "ext4")
build_args := env("BUILD_ARGUMENTS", "")
just := just_executable()

[private]
default:
    @{{ just }} --list
    
# Build the OS image from the containerfile
build $image_name=image_name $build_args=build_args:
    sudo podman build ${build_args} -t "${image_name}:latest" .

bootc *ARGS:
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
        "{{image_name}}:{{image_tag}}" bootc {{ARGS}}

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
