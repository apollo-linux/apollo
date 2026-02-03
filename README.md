# Apollo
Apollo is a bootc image built on top of Arch Linux and GNOME. It is designed for gaming, software development and general day to day use for people who want a reliable, up to date and easy to use desktop operating system. It is based on the arch-bootc image from bootcrew, with a myriad of included packages and changes for desktop usability.

## Current status
Apollo is experimental. Use with caution; stability is not guaranteed at this time and basic things *will* be missing. Be prepared to report and help fix bugs. Apollo is not seeing active development at this time as I am currently busy with uni and work. It is not, however, abandoned and forgotten about. Builds will continue daily and PRs will still be looked at when I get a chance.

## Building

In order to get a running apollo system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor. GNOME Boxes is recommended and can be installed as a flatpak with minimal effort.
