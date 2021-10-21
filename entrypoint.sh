#!/bin/sh -l
set -x

docker_folder=$(pwd)/docker
work_dir=/usr/local/$EVAL_CONTAINER_NAME 

docker rm -fv $EVAL_CONTAINER_NAME

docker run \
  --privileged \
  -d \
  --restart always \
  --name $EVAL_CONTAINER_NAME \
  -w $work_dir \
  -v $docker_folder:$work_dir \
  mjgargani/docker:dind-trybe1.0

docker exec $EVAL_CONTAINER_NAME ls -la $work_dir

# run_npm_start=$1
# wait_for_url=$2

# npm install

# if $run_npm_start ; then
#   npm start & npx wait-on $wait_for_url
# fi

# npm test -- --json --outputFile=evaluation.json
# node /evaluator.js evaluation.json .trybe/requirements.json result.json

docker rm -fv $EVAL_CONTAINER_NAME
rm -rf $docker_folder

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`
