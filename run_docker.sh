#!/bin/bash
docker run -it --env DISPLAY=$DISPLAY --name ros ros_gazebo_bluerov
#           ^              ^               ^          ^- use this container
#           ^              ^               ^- refer to it as ros
#           ^              ^ - pass in the display
#           ^- interactive shell     