#!/bin/bash

# Changement des sources APT
rm /etc/apt/sources.list.d/pve-enterprise.list
#echo "deb http://debian.mirrors.ovh.net/debian buster main
#deb-src http://debian.mirrors.ovh.net/debian buster main
#deb http://security.debian.org/debian-security buster/updates main
#deb-src http://security.debian.org/debian-security buster/updates main
# buster-updates, previously known as 'volatile'
#deb http://debian.mirrors.ovh.net/debian buster-updates main
#deb-src http://debian.mirrors.ovh.net/debian buster-updates main" > /etc/apt/sources.list

#Configuration de timezone et de locale
echo "Europe/Paris" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    dpkg-reconfigure --frontend=noninteractive locales

# Mise à jours des paquets
apt update && apt upgrade -y
apt install -y sudo 
apt install -y chpasswd
apt install -y locate
apt install -y curl
apt install -y git
apt install -y nano
apt install -y dnsutils
#Configuration de timezone et de locale
echo "Europe/Paris" > /etc/timezone
timedatectl set-timezone Europe/Paris
clear
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo "    => Mise à jours des paquets effectué."
tput setaf 7; echo "-------------------------------------------------"

# Changement du motd
ip_du_serveur=$(hostname -i)
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo " => L'adresse IP du serveur est $ip_du_serveur."
tput setaf 7; echo "-------------------------------------------------"
tput setaf 2; read -p "Entrez le nom du serveur : " name_server
echo " 
 _     _                                                                             
| |   | |                                                                       _    
| |___| |_   _   ____   ____   ____  _   _     ____   ___  ____    ___    ____ | |_  
 \_____/| | | | / _  | / _  | / ___)| | | |   / _  ) /___)|  _ \  / _ \  / ___)|  _) 
   ___  | |_| |( ( | |( ( | || |    | |_| |  ( (/ / |___ || | | || |_| || |    | |__ 
  (___)  \____| \_|| | \_||_||_|     \__  |   \____)(___/ | ||_/  \___/ |_|     \___)
               (_____|              (____/                |_|                        
             Server   : $name_server
			 
             IP       : $ip_du_serveur
			 
" > /etc/motd
tput setaf 7; echo "-------------------------------------------------"
tput setaf 7; echo "          => Le MOTD a été changé."
tput setaf 7; echo "-------------------------------------------------"
updatedb
echo ""
echo ""
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo "         => PREPARATION TERMINEE <="
tput setaf 7; echo "-------------------------------------------------"
tput setaf 2; echo ""
