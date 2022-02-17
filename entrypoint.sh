#!/bin/bash

set -x
set -m

compose_challenges_folder=$1
wait_for_url=$2

# Start docker service in background
/usr/local/bin/dockerd-entrypoint.sh &

# Wait that the docker service is up
while ! docker info; do
  echo "Waiting docker..."
  sleep 3
done

# Run default jest evaluation
npm install

# Start student compose
(cd $compose_challenges_folder && docker-compose up -d --build)

if [ $? != 0 ]; then
  echo "Compose execution error"
  exit 1
fi

npx wait-on -t 300000 $wait_for_url # wait for server until timeout

npm test -- --json --forceExit --outputFile=evaluation.json
node /evaluator.js evaluation.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`