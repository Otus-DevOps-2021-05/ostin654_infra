#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update
sleep 5
DEBIAN_FRONTEND=noninteractive apt-get install -y ruby-full ruby-bundler build-essential
