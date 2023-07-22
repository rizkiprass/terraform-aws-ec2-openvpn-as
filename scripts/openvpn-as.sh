#!/bin/bash

apt update && apt -y install ca-certificates wget net-tools gnupg
wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
echo "deb http://as-repository.openvpn.net/as/debian focal main">/etc/apt/sources.list.d/openvpn-as-repo.list
  apt update && apt -y install openvpn-as | grep -oP 'To login please use the "openvpn" account with "[^"]+" password.' > /home/ubuntu/user-admin-pass.txt

#configuration user
cd /usr/local/openvpn_as/scripts/

#Set the default authentication mode to local:
./sacli --key "auth.module.type" --value "local" ConfigPut
./sacli start

#Add a new user from scratch:
./sacli --user ${user_openvpn} --key "type" --value "user_connect" UserPropPut

# Generate a random password
password=$(openssl rand -base64 12)

#save password
echo "$password"> /home/ubuntu/user1-password.txt

# Set password for a user
./sacli --user ${user_openvpn} --new_pass "$password" SetLocalPassword

#config vpn settings
sacli ConfigQuery > config.txt
sed -E -i "s|\"vpn\.server\.routing\.private_network\.0\": \"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/[0-9]+\"|\"vpn.server.routing.private_network.0\": \"${routing_ip}\"|" config.txt

#config network settings
sed -E -i "s/\"host\.name\": \"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\"/\"host.name\": \"${ec2_public_ip}\"/" config.txt

#save config
sacli --value_file=config.txt ConfigReplace
service openvpnas restart




