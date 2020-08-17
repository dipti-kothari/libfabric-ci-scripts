#!/usr/bin/env bash

INSTALL_DIR=$1
TEST_SKIP_KMOD=$2
INSTALLER_VERSION=$3
TARGET_BRANCH=$4
if [ ${TARGET_BRANCH} == "v1.8.x" ]; then
    INSTALLER_VERSION=1.7.1
fi
pushd ${INSTALL_DIR}/aws-efa-installer-${INSTALLER_VERSION}
tar -xf efa-installer-${INSTALLER_VERSION}.tar.gz
pushd aws-efa-installer
if [ $TEST_SKIP_KMOD -eq 1 ]; then
    sudo ./efa_installer.sh -y -k
else
    sudo ./efa_installer.sh -y
fi
. /etc/profile.d/efa.sh
popd
popd
