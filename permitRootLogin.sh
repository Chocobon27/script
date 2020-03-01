#!/bin/bash
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "Port 1804" >> /etc/ssh/sshd_config
rm permitRootLogin.sh
exit
