#!/bin/sh -l
set -x

printenv

# export EVAL_CONTAINER_NAME="trybe-eval-$(cat /proc/sys/kernel/random/uuid)"

# npm install

# npm test -- --json --outputFile=evaluation.json

# node ./.github/actions/docker-jest-evaluator/evaluator.js evaluation.json .trybe/requirements.json result.json

# docker rm -fv $EVAL_CONTAINER_NAME &> /dev/null

# if [ $? != 0 ]; then
#   echo "Execution error"
#   exit 1
# fi

# echo ::set-output name=result::`cat result.json | base64 -w 0`
