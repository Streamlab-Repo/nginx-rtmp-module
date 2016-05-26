#! /bin/bash

REPO="Streamlab-Repo/nginx-rtmp-module"
BRANCH="Raspberry-1.1.7"
VERSION="1.6.2-5"
ARCH="armhf"
PAQUETES=""

PWD=$(pwd)
cd /tmp

echo ">> Descargando los paquetes Debian"
for paquete in nginx-common_${VERSION}_all.deb nginx-full_${VERSION}_${ARCH}.deb
do
  echo " (1) > Descargando '$paquete'"
  wget -O "$paquete" -o install.log "https://github.com/$REPO/raw/$BRANCH/raspberry/$paquete"
  echo " (2) > Instalando el paquete '$paquete'"
  dpkg --install "$paquete"
done

if [ $? -ne 0 ]
then
  echo ">> Instalación incompleta, solucionando dependencias"
  apt-get update
  apt-get -f -y install
fi

echo ">> Trabajo finalizado"
cd "$PWD"

