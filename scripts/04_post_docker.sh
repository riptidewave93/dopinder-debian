#!/bin/bash
set -e

# Source our common vars
scripts_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${scripts_path}/vars.sh

debug_msg "Starting 04_post_docker.sh"

if [ -d ${build_path}/final ]; then
    debug_msg "WARNING: final builddir already exists! Cleaning up..."
    rm -rf ${build_path}/final
fi
mkdir -p ${build_path}/final

# Kick off the docker to do the magics for us, since we need genimage
docker run --ulimit nofile=1024 --rm -v "${root_path}:/repo:Z" -it ${docker_tag} /repo/scripts/docker/run_mkimage_final.sh

# Just create our final dir and move bits over
TIMESTAMP=`date +%Y%m%d-%H%M`
mkdir -p ${root_path}/output/${TIMESTAMP}/kernel
mv ${build_path}/final/debian*.img.gz ${root_path}/output/${TIMESTAMP}/
cp ${build_path}/kernel/linux-*.deb ${root_path}/output/${TIMESTAMP}/kernel/
rm -rf ${build_path}/final

debug_msg "Finished 04_post_docker.sh"
