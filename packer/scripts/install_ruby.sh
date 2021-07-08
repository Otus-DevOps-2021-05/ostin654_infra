#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get remove -y unattended-upgrades
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y ruby-full ruby-bundler build-essential
