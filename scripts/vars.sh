#!/bin/bash

root_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
build_path="${root_path}/BuildEnv"

# Docker image name
docker_tag=s905-builder:builder

# Supported Devices
supported_devices=(onn-uhd)

# Toolchain
toolchain_url="https://developer.arm.com/-/media/Files/downloads/gnu/12.2.rel1/binrel/arm-gnu-toolchain-12.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz"
toolchain_filename="$(basename $toolchain_url)"
toolchain_bin_path="${toolchain_filename%.tar.xz}/bin"
toolchain_cross_compile="aarch64-none-linux-gnu-"

# U-Boot
uboot_src="https://github.com/u-boot/u-boot/archive/refs/tags/v2023.10-rc2.zip"
uboot_filename="u-boot-2023.10-rc2.zip"
uboot_overlay_dir="u-boot"

# Kernel
kernel_src="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/snapshot/linux-6.5-rc6.tar.gz"
kernel_filename="linux-6.5-rc6.tar.gz"
kernel_config="s905_defconfig"
kernel_overlay_dir="kernel"

# Distro
distrib_name="debian"
deb_mirror="https://mirrors.kernel.org/debian/"
deb_release="bookworm"
deb_arch="arm64"
fs_overlay_dir="filesystem"

debug_msg () {
    BLU='\033[0;32m'
    NC='\033[0m'
    printf "${BLU}${@}${NC}\n"
}

error_msg () {
    BLU='\033[0;31m'
    NC='\033[0m'
    printf "${BLU}${@}${NC}\n"
}