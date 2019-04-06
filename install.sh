#!/usr/bin/env bash

YELLOW='\e[93m'
BLUE='\e[94m'
CLEAR='\e[0m'


# APT

echo "${BLUE}Update Packaging Tool${CLEAR}"
sudo apt update

echo "${BLUE}Upgrade Packages${CLEAR}"
sudo apt autoremove
sudo apt upgrade


while true; do
  echo "${YELLOW}Do you want to install Docker ?${CLEAR}"
  read -p "[y/N] : " INSTALL_DOCKER
  case $INSTALL_DOCKER in
    [Yy]* )

      #  Docker

      echo "${BLUE}Install Packages${CLEAR}"
      sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

      echo "${BLUE}Install Docker${CLEAR}"
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt install docker-ce docker-ce-cli containerd.io

      echo "${BLUE}Install Docker Compose${CLEAR}"
      sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose

      break ;;
    * )
      break ;;
  esac
done


while true; do
  echo "${YELLOW}Do you want to install Yarn locally ?${CLEAR}"
  read -p "[y/N] : " INSTALL_YARN
  case $INSTALL_YARN in
    [Yy]* )

      #  Yarn

      echo "${BLUE}Install Yarn${CLEAR}"
      curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
      sudo apt install yarn
      echo "${BLUE}Install Package Dependencies${CLEAR}"
      sudo yarn install

      break ;;
    * )
      break ;;
  esac
done


while true; do
  echo "${YELLOW}Do you want to install Flask locally ?${CLEAR}"
  read -p "[y/N] : " INSTALL_FLASK
  case $INSTALL_FLASK in
    [Yy]* )

      #  Flask

      echo "${BLUE}Install Virtual Environment${CLEAR}"
      sudo apt-get install python3-venv python-setuptools

      echo "${BLUE}Create Virtual Environment${CLEAR}"
      python3 -m venv .venv

      echo "${BLUE}Activate Virtual Environment${CLEAR}"
      . .venv/bin/activate

      echo "${BLUE}Upgrade Pip, Setup Tools and Wheel${CLEAR}"
      pip install --upgrade pip setuptools wheel

      echo "${BLUE}Install Package Requirements${CLEAR}"
      pip install -r requirements.txt

      echo "${BLUE}Deactivate Virtual Environment${CLEAR}"
      deactivate

      break ;;
    * )
      break ;;
  esac
done
