#!/bin/sh -l
set -x

# puppeteer requirements
sudo apt install -y ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils

export EVAL_CONTAINER_NAME="trybe-eval-$(cat /proc/sys/kernel/random/uuid)"

npm install

npm test -- --json --outputFile=evaluation.json

node ./.github/actions/docker-jest-evaluator/evaluator.js evaluation.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  docker rm -fv $(docker ps -qaf name=$EVAL_CONTAINER_NAME) &> /dev/null
  echo "Execution error"
  exit 1
fi

docker rm -fv $(docker ps -qaf name=$EVAL_CONTAINER_NAME) &> /dev/null
echo ::set-output name=result::`cat result.json | base64 -w 0`
