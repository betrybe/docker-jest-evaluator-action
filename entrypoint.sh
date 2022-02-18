#!/bin/bash

set -x

compose_challenges_folder=$INPUT_CHALLENGES_FOLDER
wait_for_url=$INPUT_WAIT_FOR

# Running the install before compose, as there may be post-install features
npm install

# Start student compose
(cd $compose_challenges_folder && docker-compose up -d --build)

if [ $? != 0 ]; then
  echo "Compose execution error"
  exit 1
fi

if [ ! -z "$wait_for_url" ] ; then
  npx wait-on -t 300000 $wait_for_url # wait for server until timeout
fi

npm test -- --json --forceExit --outputFile=evaluation.json
node /evaluator.js evaluation.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`