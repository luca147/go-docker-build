#!/bin/sh
docker build . -f Dockerfile.alpine  -t demo_go_img_size_alpine --label demo_go_img_size --no-cache

docker build . -f Dockerfile.distroless  -t demo_go_img_size_distroless --label demo_go_img_size --no-cache

docker build . -f Dockerfile.scratch  -t demo_go_img_size_scratch --label demo_go_img_size --no-cache

docker image prune --force --filter='label=demo_go_img_size'

docker image ls --filter='label=demo_go_img_size'