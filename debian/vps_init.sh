#!/bin/bash

# sshd
echo "sshd"
sed -i -e 's/^[# ]*PubkeyAuthentication .*/PubkeyAuthentication yes/' -e 's/^[# ]*PasswordAuthentication .*/PasswordAuthentication no/' -e 's/^[# ]*ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# vimrc
echo "vimrc"
curl https://raw.githubusercontent.com/regod/dotfile/master/vim/_vimrc.simple -o ~/.vimrc

echo "apt update"
apt-get update

# locale
echo "locale"
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
echo -e "LANG=en_US.UTF-8\nLC_CTYPE=en_US.UTF-8" > /etc/default/locale

# editor
echo "editor: vim.basic"
update-alternatives --set editor /usr/bin/vim.basic

# cst time
echo "localtime: CST"
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# nginx
echo "nginx"
apt-get install -y nginx
curl https://raw.githubusercontent.com/regod/dotfile/master/nginx/nginx.conf -o /etc/nginx/nginx.conf
nginx -t
nginx
mkdir -p /etc/nginx/cert/eleave.org/
