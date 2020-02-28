#!/bin/bash
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
rm permitRootLogin.sh
service restart networking 
service restart ssh
exit
