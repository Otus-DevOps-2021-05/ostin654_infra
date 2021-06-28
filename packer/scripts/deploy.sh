#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get install -y git

git clone -b monolith https://github.com/express42/reddit.git

cd reddit
bundle install

mv /tmp/app.service /etc/systemd/system/app.service
chown root:root /etc/systemd/system/app.service
systemctl daemon-reload
systemctl start app.service
systemctl enable app.service
systemctl status app.service
