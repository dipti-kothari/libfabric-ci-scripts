#!/usr/bin/env bash

source ~/curl_wget_check.sh
curl_cmd="curl ${CURL_OPT} -O https://s3.us-west-2.amazonaws.com/subspace-intelmpi/l_mpi_2019.10.317.tgz"
curl_check "$curl_cmd" "l_mpi_2019.10.317.tgz"
tar -zxf l_mpi_2019.10.317.tgz
cd l_mpi_2019.10.317
sed -e "s/decline/accept/" silent.cfg > accept.cfg
sudo ./install.sh -s accept.cfg
