#!/bin/bash
docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --name ros ros_gazebo_bluerov
#           ^      ^             ^               ^                                              ^              ^- use this container
#           ^      ^             ^               ^                                              ^- refer to it as ros
#           ^      ^             ^               ^- share x server
#           ^      ^             ^ - pass in the display
#           ^      ^- also for the display
#           ^- interactive shell     