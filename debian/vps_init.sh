#!/bin/bash

function color_echo() {
    echo "\033[32m$1\033[0m"
}

# sshd
color_echo "sshd"
sed -i -e 's/^[# ]*PubkeyAuthentication .*/PubkeyAuthentication yes/' -e 's/^[# ]*PasswordAuthentication .*/PasswordAuthentication no/' -e 's/^[# ]*ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# vimrc
color_echo "vimrc"
curl https://raw.githubusercontent.com/regod/dotfile/master/vim/_vimrc.simple -o ~/.vimrc

color_echo "apt update"
apt-get update

# locale
color_echo "locale"
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
echo -e "LANG=en_US.UTF-8\nLC_CTYPE=en_US.UTF-8" > /etc/default/locale

# editor
color_echo "editor: vim.basic"
update-alternatives --set editor /usr/bin/vim.basic

# cst time
color_echo "localtime: CST"
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# nginx
color_echo "nginx"
apt-get install -y nginx
curl https://raw.githubusercontent.com/regod/dotfile/master/nginx/nginx.conf -o /etc/nginx/nginx.conf
mkdir -p /etc/nginx/cert/eleave.org/
scp -o StrictHostKeyChecking=no -r root@budget.eleave.org:/etc/nginx/cert/eleave.org /etc/nginx/cert/
nginx -t
nginx

mkdir -p ~/.vim/syntax/
curl "https://www.vim.org/scripts/download_script.php?src_id=19394" -o ~/.vim/syntax/nginx.vim
echo "au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,*/nginx/*.conf if &ft == '' | setfiletype nginx | endif" >> ~/.vim/filetype.vim

# v2ray
color_echo "v2ray"
cd ~/
curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
bash install-release.sh
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone git@github.com:regod/config.git
cp config/v2ray/config.json /usr/local/etc/v2ray/
cp /etc/nginx/cert/eleave.org/cert.pem /usr/local/etc/v2ray/v2ray.crt \
    && cp /etc/nginx/cert/eleave.org/key.pem /usr/local/etc/v2ray/v2ray.key \
    && chmod a+r /usr/local/etc/v2ray/v2ray.* \
    && systemctl restart v2ray
sleep 1
systemctl status v2ray

