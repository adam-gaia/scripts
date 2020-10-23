#!/bin/bash
# See https://stackoverflow.com/questions/13756800/how-to-download-all-dependencies-and-packages-to-directory
#    and https://stackoverflow.com/questions/22008193/how-to-list-download-the-recursive-dependencies-of-a-debian-package
#    for more info

#if [[ "${#}" -eq '0' ]]; then
#    echo "Usage:"
#    echo "    installToRobot.sh [package1] [package2] ..."
#    exit 0
#fi

PACKAGES=(cgroupfs-mount docker.io python3-venv)

mkdir -p "${HOME}/apt"
cd "${HOME}/apt"

apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests \
  --no-conflicts --no-breaks --no-replaces --no-enhances \
  --no-pre-depends ${PACKAGES[@]} | grep "^\w") || exit

#dpkg-scanpackages "${HOME}/apt" | gzip -9c > "${HOME}/apt/Packages.gz"

scp -Cr "${HOME}/apt" robot:~/apt

#ssh robot -t "echo 'deb [trusted=yes] file:/home/sarcos/apt ./' | sudo tee -a /etc/apt/sources.list"
#ssh robot -t 'sudo apt update'
#ssh robot -t "sudo apt install ${PACKAGES[@]} -y"



# sudo apt install ./docker.io_18.09.1+dfsg1-7.1+deb10u2_amd64.deb ./libltdl7_2.4.6-9_amd64.deb  ./libnspr4_2%3a4.20-1_amd64.deb ./libnss3_2%3a3.42.1-1+deb10u3_amd64.deb ./runc_1.0.0~rc6+dfsg1-3_amd64.deb ./tini_0.18.0-1_amd64.deb 
# TODO: add user to docekr group
