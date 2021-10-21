#!/bin/sh -l
set -x

# run_npm_start=$1
# wait_for_url=$2

# docker_dir=$(pwd)/docker
# work_dir=/$EVAL_CONTAINER_NAME

# ls -la $(pwd)/docker

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

# if $run_npm_start ; then
#   npm start & npx wait-on $wait_for_url
# fi

# npm test -- --json --outputFile=evaluation.json

ls -la $(pwd)

# node /evaluator.js evaluation.json .trybe/requirements.json result.json

# docker rm -fv $EVAL_CONTAINER_NAME &> /dev/null

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`
