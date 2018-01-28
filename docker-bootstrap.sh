#!/usr/bin/env bash
set -e

# Change mirror to use httpredir.debian.org
sed -i 's/deb.debian.org/httpredir.debian.org/g' /etc/apt/sources.list

apt-get update && apt-get install -y wget
KEYRING_PKG="http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb"
wget -O /tmp/keyring.deb "${KEYRING_PKG}"
dpkg -i /tmp/keyring.deb && rm -v /tmp/keyring.deb

echo 'deb http://www.deb-multimedia.org stable main non-free' > /etc/apt/sources.list.d/deb-multimedia.list
apt-get update && apt-get install -y ffmpeg
