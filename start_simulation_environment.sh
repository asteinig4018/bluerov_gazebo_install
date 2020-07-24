#!/bin/bash

# Start ROS
roscore &
sleep 3

# Gazebo (ROS node)
cd catkin_ws_bluerov/src/bluerov_ros_playground
source gazebo.sh
rosrun gazebo_ros gazebo worlds/underwater.world -u &

# QGroundControl
#cd ../../../..
#./QGroundControl.AppImage &

# ArduSub
cd /usr/bluerov_simulation/ardupilot/ArduSub
sim_vehicle.py -f gazebo-bluerov2 -I 0 -j4 -D -L RATBeach --console