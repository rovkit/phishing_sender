#!/bin/bash

wget https://github.com/gophish/gophish/releases/download/v0.11.0/gophish-v0.11.0-linux-64bit.zip 
apt install -y unzip
mkdir gophish
unzip gophish-v0.11.0-linux-64bit.zip  -d gophish

systemctl stop apache2
systemctl mask apache2


chmod +x gophish/gophish
cd gophish
#./gophish

