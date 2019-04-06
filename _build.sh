#!/usr/bin/env bash

echo "\e[94mBuild Image\e[0m"
sudo docker build --target app .
