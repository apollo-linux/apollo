# Apollo
Apollo is a bootc image built on top of Arch Linux and GNOME. It is designed for gaming, software development and general day to day use for people who want a reliable, up to date and easy to use desktop operating system. It is based on the arch-bootc image from bootcrew, with a myriad of included packages and changes for desktop usability.

## Current status
Apollo is in an experimental pre-alpha state. Use with caution; stability is not guaranteed at this time and basic things *will* be missing. You should be fully prepared to report bugs and in general, help is appreciated.

## Building

In order to get a running apollo system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor. GNOME Boxes is recommended and can be installed as a flatpak with minimal effort.
