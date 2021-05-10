#!/bin/bash
#######
apt-get install curl sudo wget git gnupg2 net-tools -y
#######
curl -s https://install.zerotier.com | sudo bash
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
curl -O https://s3-us-west-1.amazonaws.com/key-networks/deb/ztncui/1/x86_64/ztncui_0.7.1_amd64.deb
sudo apt-get install ./ztncui_0.7.1_amd64.deb
#######SSL_TLS
cd /opt/key-networks/ztncui/etc/tls
rm -f privkey.pem fullchain.pem
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privkey.pem -out fullchain.pem
chown ztncui.ztncui *.pem
chmod 600 privkey.pem
#######ENTORNO
sudo sh -c "echo 'HTTPS_PORT=3443' > /opt/key-networks/ztncui/.env"
sudo sh -c "echo 'NODE_ENV=production' >> /opt/key-networks/ztncui/.env"
#######Servicio
sudo systemctl restart ztncui
#######Datos
#Usuario: admin
#Password: password
