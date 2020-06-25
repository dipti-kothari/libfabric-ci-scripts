#!/usr/bin/env bash

cd ${INSTALL_DIR}
curl ${CURL_OPT} -O https://s3.us-west-2.amazonaws.com/subspace-intelmpi/l_mpi_2019.7.217.tgz
tar -zxf l_mpi_2019.7.217.tgz
cd ${INSTALL_DIR}/l_mpi_2019.7.217
sed -e "s/decline/accept/" silent.cfg > accept.cfg
sudo ./install.sh -s accept.cfg
