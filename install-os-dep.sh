#!/usr/bin/env bash

alinux_update()
{
    sudo yum -y update
}
alinux_install_deps()
{
    sudo yum -y groupinstall 'Development Tools'
}
rhel_update()
{
    sudo yum -y update
}
rhel_install_deps()
{
    # Optional and extras needed for rdma-core build
    sudo yum -y groupinstall 'Development Tools'
    sudo yum-config-manager --enable rhel-7-server-rhui-optional-rpms
    # An update after enabling the rhui optional repository seems to be needed
    # to refresh the CA certs.
    sudo yum -y update
}
centos_update()
{
    # Update and reboot already handled in check_provider_os()
    return 0
}
centos_install_deps()
{
    sudo yum -y groupinstall 'Development Tools'
}
ubuntu_update()
{
    sudo DEBIAN_FRONTEND=noninteractive apt-get update
}
ubuntu_install_deps()
{
    sudo DEBIAN_FRONTEND=noninteractive apt -y install python
    sudo DEBIAN_FRONTEND=noninteractive apt -y install autoconf
    sudo DEBIAN_FRONTEND=noninteractive apt -y install libltdl-dev
    sudo DEBIAN_FRONTEND=noninteractive apt -y install make
}
$1_$2
