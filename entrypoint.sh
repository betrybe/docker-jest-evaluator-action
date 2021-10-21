#!/bin/sh -l
set -x

# docker_dir=$(pwd)/docker
# work_dir=/$EVAL_CONTAINER_NAME

# docker rm -fv $EVAL_CONTAINER_NAME &> /dev/null

# docker run \
#   --name $EVAL_CONTAINER_NAME \
#   --privileged \
#   -d \
#   -w $work_dir \
#   -v $docker_dir:$work_dir \
#   mjgargani/docker:dind-trybe1.0 \

# docker exec $EVAL_CONTAINER_NAME ls -la

# docker exec $EVAL_CONTAINER_NAME ls -la ..

npm install

npm test -- --json --outputFile=evaluation.json

node ./.github/actions/docker-jest-evaluator/evaluator.js evaluation.json .trybe/requirements.json result.json

# docker rm -fv $EVAL_CONTAINER_NAME &> /dev/null

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`
