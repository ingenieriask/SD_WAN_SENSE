#!/bin/bash
###PfSense Script####
#Requisitos
mkdir /usr/ports/
mkdir /usr/ports/Mk
#Paquetes
echo FreeBSD: { enabled: yes  }  > /usr/local/etc/pkg/repos/FreeBSD.conf
cp /usr/local/etc/pkg/repos/pfSense.conf /usr/local/etc/pkg/repos/pfSense.conf.bk
sed '1d' /usr/local/etc/pkg/repos/pfSense.conf.bk >  /usr/local/etc/pkg/repos/pfSense.conf
echo "FreeBSD: { enabled: yes }" >> /usr/local/etc/pkg/repos/pfSense.conf
yes | pkg install git gcc zerotier
cat /usr/local/etc/pkg/repos/pfSense.conf.bk > /usr/local/etc/pkg/repos/pfSense.conf
#Directorio
cd /tmp/
#Archivos necesarios
git clone https://github.com/ingenieriask/SD_WAN_SENSE.git
#Direcorio General
cd SD_WAN_SENSE/
#Copiar archivos a al directorio de requisito
cp -R Mk/* /usr/ports/Mk/
#Acceso al directorio para copilar el txz
cd pfSense-pkg-zerotier/
#Copilar
make clean ; make package COMPILER_TYPE=gcc
#Instalar archivo Copilado
pkg add /tmp/SD_WAN_SENSE/pfSense-pkg-zerotier/work/pkg/pfSense-pkg-zerotier-0.00.1.txz
