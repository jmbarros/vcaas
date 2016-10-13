#!/bin/bash
##########################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
##############################
#creating a 
echo "Digit your IBM Mail:"
read email	
ssh-keygen -t rsa -b 4096 -C $email -N "" -f ~/.ssh/id_rsa
key=`cat ~/.ssh/id_rsa.pub`
echo "Copy and Paste this KEY at IBM Corporate GitHub"
echo "##############"
echo $key
echo "##############"
echo "enter at: https://github.ibm.com/settings/keys"
#creating the ssl key at know hosts 
echo 'github.ibm.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC1Sg96+K5rc8ZTYhidXI1Q6qUBRgrC51I2pUop4xo4keH8r/5V1W+z2dZNKZsVLW12ulIAe9yorXt2MrI8V0XE=' > ~/.ssh/known_hosts
