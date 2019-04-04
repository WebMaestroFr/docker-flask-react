#!/usr/bin/env bash

echo "\e[94mBuild Static Client\e[0m"
sudo yarn build
sudo rm -R ./app/static
sudo mv ./build ./app/static

echo "\e[94mBuild Production Container\e[0m"
sudo docker build -t app-production -f Dockerfile.flask .
