#!/bin/bash

#setup
export PATH=$PATH:/usr/bluerov_simulation/ardupilot/Tools/autotest
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/ros/melodic/lib

# Start ROS
roscore &
sleep 3

# Gazebo (ROS node)
cd /usr/bluerov_simulation/catkin_ws_bluerov/src/bluerov_ros_playground
source gazebo.sh
rosrun gazebo_ros gazebo worlds/underwater.world -u &

# QGroundControl
#cd ../../../..
#./QGroundControl.AppImage &

# ArduSub
cd /usr/bluerov_simulation/ardupilot/ArduSub
pip install -U mavproxy
sim_vehicle.py -f gazebo-bluerov2 -I 0 -j4 -D -L RATBeach --console