#!/bin/bash
XSOCK=/tmp/.X11-unix
docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $XSOCK:$XSOCK --name ros ros_gazebo_bluerov
#           ^      ^             ^               ^                                                               ^              ^- use this container
#           ^      ^             ^               ^                                                               ^- refer to it as ros
#           ^      ^             ^               ^- share x server
#           ^      ^             ^ - pass in the display
#           ^      ^- also for the display
#           ^- interactive shell     