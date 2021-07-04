#!/bin/bash

sleep 30

DEBIAN_FRONTEND=noninteractive apt-get remove -y unattended-upgrades

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org

mv /tmp/mongod.conf /etc/mongod.conf

systemctl start mongod
systemctl enable mongod
