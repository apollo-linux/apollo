# Contributing
Thank you for your interest in contributing to Apollo. To help your contribution be accepted more easily, please read through the following first. 

## Building
Apollo is made with mkosi and bootc. You'll need mkosi, python, just, and preferably podman (docker should work too). A hypervisor is also recommended for testing images. 

You can build a bootc-compatible oci archive with mkosi (an Arch-based environment is currently recommended) using the following command:
```bash
just build-bootc
```

To load the built oci archive into your *rootless* container storage, you can run the following:
```bash
just load
```

To build a bootable image, follow the following commands:
```bash
sudo just load # the next command requires rootful podman.
sudo just generate-bootable-image
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor, such as QEMU, Virt-Manager or GNOME Boxes.

## Commit style
Apollo uses the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format, as seen in the following:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

In particular, we primarily use the following types:
- ```feat```: adding a new major feature to Apollo
- ```fix```: fixing an issue in Apollo or the repository (e.g., ci workflows, mkosi configuration)
- ```chore```: component updates, refactors or other changes that can't otherwise be classed as a feat or fix
- ```docs```: adding documentation to the repositories, including .md files in the repo.

When choosing the scope to use, it's ultimately your discretion. As a general rule, profile-specific changes should use the profile name, ci/workflow changes should use `ci` and changes to the base config should use the most appropriate file name (e.g. extra). If appropriate, scope may be omitted entirely.

## Code of Conduct
Please make sure that your contribution, including communication around it, follows the [Apollo Code of Conduct](https://docs.getapollo.dev/docs/about/code-of-conduct/). This is currently the Contributor Covenant 3.0. 

# AI use
Please see the [Apollo Generative AI policy](https://docs.getapollo.dev/docs/contributing/gen-ai/). TLDR: AI contributions are unwelcome here.
