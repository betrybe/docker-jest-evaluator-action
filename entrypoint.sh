#!/bin/sh -l
set -x

export EVAL_CONTAINER_NAME="trybe-eval-$(cat /proc/sys/kernel/random/uuid)"

npm install

npm test -- --json --outputFile=evaluation.json

node ./.github/actions/docker-jest-evaluator/evaluator.js evaluation.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  docker rm -fv $EVAL_CONTAINER_NAME &> /dev/null
  echo "Execution error"
  exit 1
fi

echo "result=`cat result.json | base64 -w 0`" >> $GITHUB_OUTPUT
