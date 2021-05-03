#!/bin/bash
###PfSense Script####
#Requisitos
mkdir -R /usr/ports/Mk
#Paquetes
pkg install git
pkg add http://pkg.freebsd.org/freebsd:12:x86:64/latest/All/zerotier-1.6.5.txz 
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
make clean ; make package
#Instalar archivo Copilado
pkg add /tmp/SD_WAN_SENSE/pfSense-pkg-zerotier/work/pkg/pfSense-pkg-zerotier-0.00.1.txz
