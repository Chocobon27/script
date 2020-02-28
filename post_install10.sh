#!/bin/sh

# Changement des sources APT
echo "deb http://debian.mirrors.ovh.net/debian buster main
deb-src http://debian.mirrors.ovh.net/debian buster main
deb http://security.debian.org/debian-security buster/updates main
deb-src http://security.debian.org/debian-security buster/updates main
# buster-updates, previously known as 'volatile'
deb http://debian.mirrors.ovh.net/debian buster-updates main
deb-src http://debian.mirrors.ovh.net/debian buster-updates main" > /etc/apt/sources.list

#Configuration de timezone et de locale
echo "Europe/Paris" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# nb_NO.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="fr_FR.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=fr_FR.UTF-8



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
clear
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo "    => Mise à jours des paquets effectué."
tput setaf 7; echo "-------------------------------------------------"
# Gestion des utilisateurs
tput setaf 2; read -p "Entrez le mot de passe pour Root : " password_root
tput setaf 2; echo "root:$password_root" | chpasswd
tput setaf 7; echo "-------------------------------------------------"
tput setaf 7; echo "    => Mot de passe de Root a été changé."
tput setaf 7; echo "-------------------------------------------------"
tput setaf 2; read -p "Entrez un nom d'utilisateur : " name_user
tput setaf 2; read -p "Entrez le mot de passe pour l'utilisateur $name_user : " password_user
tput setaf 2; adduser --quiet --disabled-password --shell /bin/bash --home /home/$name_user --gecos "User" $name_user
tput setaf 2; echo "$name_user:$password_user" | chpasswd
tput setaf 2; adduser $name_user sudo
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo "    => L'utilisateur $name_user a été créé."
tput bold; tput setaf 7; echo "    => $name_user fait parti du groupe sudo."
tput setaf 7; echo "-------------------------------------------------"
# Changement du motd
ip_du_serveur=$(hostname -i)
tput setaf 7; echo "-------------------------------------------------"
tput bold; tput setaf 7; echo " => L'adresse IP du serveur est $ip_du_serveur."
tput setaf 7; echo "-------------------------------------------------"
tput setaf 2; read -p "Entrez le nom du serveur : " name_server
echo "
 __   __                                                             _   
 \ \ / /   _  __ _  __ _ _ __ _   _        ___  ___ _ __   ___  _ __| |_ 
  \ V / | | |/ _` |/ _` | '__| | | |_____ / _ \/ __| '_ \ / _ \| '__| __|
   | || |_| | (_| | (_| | |  | |_| |_____|  __/\__ \ |_) | (_) | |  | |_ 
   |_| \__,_|\__, |\__,_|_|   \__, |      \___||___/ .__/ \___/|_|   \__|
             |___/            |___/                |_|                   
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
