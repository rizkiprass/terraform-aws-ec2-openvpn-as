#!/bin/bash

apt update && apt -y install ca-certificates wget net-tools gnupg
wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
echo "deb http://as-repository.openvpn.net/as/debian focal main">/etc/apt/sources.list.d/openvpn-as-repo.list
apt update && apt -y install openvpn-as | grep -oP 'To login please use the "openvpn" account with "[^"]+" password.' > /home/ubuntu/login-user-pass.txt

#configuration user
cd /usr/local/openvpn_as/scripts/

#Set the default authentication mode to local:
./sacli --key "auth.module.type" --value "local" ConfigPut
./sacli start

#Add a new user from scratch:
./sacli --user ${user_openvpn} --key "type" --value "user_connect" UserPropPut

# Generate a random password
password=$(openssl rand -base64 12)

# Set password for a user
./sacli --user ${user_openvpn} --new_pass "$password" SetLocalPassword
