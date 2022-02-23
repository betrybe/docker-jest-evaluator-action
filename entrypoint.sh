#!/bin/bash

set -x

docker_challenges_folder=$INPUT_CHALLENGES_FOLDER
requires_puppeteer_dependencies=$INPUT_PUPPETEER_TEST
up_compose=$INPUT_RUN_COMPOSE
wait_for_url=$INPUT_WAIT_FOR
current_action_folder=$TEST_ACTION_PATH

echo "----------------"
printenv
echo "----------------"

# if [ "$requires_puppeteer_dependencies" == "true" ]; then
#   sudo apt update

#   # Install chrome´s puppeteer requirements: https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix
#   sudo apt install -y ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils
# fi

# Running the install before compose, as there may be post-install features
# npm install

# if [ "$up_compose" == "true" ]; then
#   # Install docker-compose
#   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#   sudo chmod +x /usr/local/bin/docker-compose
#   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#   # Start student compose
#   (cd $docker_challenges_folder && docker-compose up -d --build)

#   if [ $? != 0 ]; then
#     echo "Compose execution error"
#     exit 1
#   fi
  
#   if [ ! -z $wait_for_url ]; then
#     # wait for server until timeout
#     echo "Waiting for the compose application to be established"
#     npx wait-on -t 30000 $wait_for_url
#   fi

#   if [ $? != 0 ]; then
#     echo "Compose execution error"
#     exit 1
#   fi
# fi

# Run jest test
# npm test -- --json --forceExit --outputFile=evaluation.json

echo "----------------"
ls -la 
echo "----------------"

node $current_action_folder/evaluator.js evaluation.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  echo "Test execution error"
  exit 1
fi

if [ "$up_compose" == "true" ]; then
  (cd $docker_challenges_folder && docker-compose down --remove-orphans &> /dev/null)
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`