#!/usr/bin/env bash

echo "\e[94mUpdate Packaging Tool\e[0m"
sudo apt update

echo "\e[94mInstall Packages\e[0m"
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common python3-venv python-setuptools

echo "\e[94mInstall Docker\e[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install docker-ce docker-ce-cli containerd.io

echo "\e[94mInstall Docker Compose\e[0m"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "\e[94mInstall Yarn\e[0m"
curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
sudo apt install yarn
