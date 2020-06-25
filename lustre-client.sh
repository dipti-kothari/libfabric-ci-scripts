#!/usr/bin/env bash

set -xe
alinux1() {
    sudo yum install -y lustre-client
}
alinux2() {
    sudo amazon-linux-extras install -y lustre2.10
}
ubuntu1604() {
    wget -O - https://fsx-lustre-client-repo-public-keys.s3.amazonaws.com/fsx-ubuntu-public-key.asc | sudo apt-key add -
    sudo bash -c 'echo "deb https://fsx-lustre-client-repo.s3.amazonaws.com/ubuntu xenial main" > /etc/apt/sources.list.d/fsxlustreclientrepo.list && apt-get update'
    sudo apt install -y lustre-client-modules-$(uname -r)
}
ubuntu1804() {
    ubuntu1604
}
rhel76() {
    sudo yum -y install wget
    sudo yum -y install https://downloads.whamcloud.com/public/lustre/lustre-2.10.8/el7/client/RPMS/x86_64/kmod-lustre-client-2.10.8-1.el7.x86_64.rpm
    sudo yum -y install https://downloads.whamcloud.com/public/lustre/lustre-2.10.8/el7/client/RPMS/x86_64/lustre-client-2.10.8-1.el7.x86_64.rpm
}
rhel_client() {
    sudo yum -y install wget
    sudo wget https://fsx-lustre-client-repo-public-keys.s3.amazonaws.com/fsx-rpm-public-key.asc -O /tmp/fsx-rpm-public-key.asc
    sudo rpm --import /tmp/fsx-rpm-public-key.asc
    sudo wget https://fsx-lustre-client-repo.s3.amazonaws.com/el/7/fsx-lustre-client.repo -O /etc/yum.repos.d/aws-fsx.repo
    sudo yum install -y kmod-lustre-client lustre-client
}
rhel77() {
    rhel_client
}
rhel78() {
    rhel_client
}
centos7() {
    rhel_client
}
mount() {
    sudo mount -t lustre -o noatime,flock,_netdev ${fsx_id}.fsx.us-west-2.amazonaws.com@tcp:/fsx /fsx
    sudo chmod -R 777 /fsx
}
install_client() {
    ${distro}
    sudo mkdir /fsx
    sudo chmod -R 777 /fsx
    echo "${fsx_dns}@tcp:/fsx /fsx lustre defaults,noatime,flock,_netdev 0 0" | sudo tee -a /etc/fstab
    # Reboot is required for the lustre modules to load
    sudo reboot & exit
}
function=$1
fsx_id=$2
distro=$3
fsx_dns=$4
case "$function" in
    install_client)
        install_client
        ;;
    mount)
        if [[ "$(df -T | grep /fsx)" ]]; then
            sudo chmod -R 777 /fsx
        else
            mount
        fi
        ;;
esac
