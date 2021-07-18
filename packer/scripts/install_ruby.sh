#!/bin/bash

sleep 30

DEBIAN_FRONTEND=noninteractive apt-get remove -y unattended-upgrades
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git ruby-full ruby-bundler build-essential
