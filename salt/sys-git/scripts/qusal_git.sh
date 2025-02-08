#!/bin/bash

export http_proxy='http://10.137.0.33:8118'
export https_proxy='http://10.137.0.33:8118'

cd /home/user

gpg --import .gnupg/download/blacky.pub
gpg --import .gnupg/download/blacky.key
gpg --import-ownertrust .gnupg/download/otrust.txt

mkdir --force -m 770 mirror
cd mirror
git clone https://github.com/gaschz/qusal.git
git clone https://github.com/gaschz/dotfiles.git
git clone https://github.com/gaschz/qubes-pass.git
git clone https://codeberg.org/gaschz/passff-host.git

cd qusal
git config --global user.name "Blacky"
git config --global user.email "gaschz@kisss.de"
git config --global user.signingkey "8ACDC545CD44CD87"

git remote add local ~/src/qusal
git remote add gitea http://meister@localhost:3000/meister/qusal
git remote add gaschz https://gaschz@github.com/gaschz/qusal
git push -u gaschz main
git switch more_vms
