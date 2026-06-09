# Rebase between release channels and images
rebase-helper:
    #!/usr/bin/env bash
    set -euo pipefail

    FULL_IMAGE="$(sudo bootc status --format json | \
        jq ".spec.image.image" | \
        sed -e "s/ghcr.io\/apollo-linux\///" \
        -e "s/\"//g" \
        )"

    IMAGE="$(echo "$FULL_IMAGE" | cut -f1 -d:)"
    CHANNEL="$(echo "$FULL_IMAGE" | cut -f2 -d:)"

    printf "You are currently using: $IMAGE:$CHANNEL \n\n"

    CHOICE="$(gum choose \
        --header="Rebase helper" \
        "Get current image info" \
        "Change release channel" \
        "Change image" \
        )"

    if [ "$CHOICE" = "Change release channel" ]; then
        printf "For more information on release channels, see https://docs.getapollo.dev/docs/using-apollo/system-administration/#apollo-release-channels \n\n"

        TARGET_CHANNEL="$(gum choose \
            --header="Choose a target channel" \
            "stable" \
            "stable-lts" \
            "latest" \
            )"

        TARGET_IMAGE="$IMAGE:$TARGET_CHANNEL"

        CONFIRM="$(gum confirm \
            "Rebase to $TARGET_IMAGE?"
            )"
        
        sudo bootc switch "ghcr.io/apollo-linux/$TARGET_IMAGE"
    fi