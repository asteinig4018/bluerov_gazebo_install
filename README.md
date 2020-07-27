# BlueRov2 Gazebo Utilities Install
## About
Installs all necessary tools and libraries to run Gazebo with mavros and ardusub in linux.

## Docker
1. Install docker
2. ```build_docker.sh``` (might need sudo)
3. Wait a long time
4. ```run_docker.sh``` (migiht need sudo)
5. Inside docker, run ```install_gazebo_bluerov_tools.sh```
6. Once done, ```remove_container.sh``` (might need sudo)

## Requires
You must install gazebo before running this script. Tested with Gazebo 9.0.

## Use

Run not as root. QGroundControl must be installed manually.

## Reference

Based on: https://gist.github.com/monabf/bc04b7ab366f812c645bf0aa6f22c8de#file-bluerov2_ardusub_sitl_tutorial-txt-L74

