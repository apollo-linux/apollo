#!/bin/bash

set -ouex pipefail

echo "Setting OS Release information"

sed -i '1c NAME="Apollo"' /etc/os-release
sed -i '2c PRETTY_NAME="Apollo"' /etc/os-release
sed -i '7c HOME_URL="https://github.com/fizzyizzy05/apollo"' /etc/os-release
sed -i '10c BUG_SUPPORT_URL="https://github.com/fizzyizzy05/apollo/issues"' /etc/os-release
