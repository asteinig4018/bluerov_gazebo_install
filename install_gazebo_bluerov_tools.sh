#!/bin/bash
#INSTALLs all necessary components for bluerov
#REQUIRES ros-melodic is installed


#INSTALL the following packages
#sudo apt-get install ros-melodic-mavros
#sudo apt-get install ros-melodic-mavros-extras
#sudo apt-get install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio -y
#sudo apt-get install git
#sudo apt-get install ros-melodic-joy*


mkdir -p bluerov_simulation/catkin_ws_bluerov/src
cd bluerov_simulation/catkin_ws_bluerov

catkin_make
cd ..
git clone https://github.com/bluerobotics/freebuoyancy_gazebo.git
cd freebuoyancy_gazebo
mkdir build
cd build
cmake ../

#make bouyancy
make
#export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:~/bluerov_simulation/freebuoyancy_gazebo/build
cd ../..
#install ardupilot gazebo
git clone -b add_link https://github.com/patrickelectric/ardupilot_gazebo.git
cd ardupilot_gazebo
mkdir build
cd build
cmake ../
make
echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc
cd ../models
echo "export GAZEBO_MODEL_PATH=$(pwd)">> ~/.bashrc
cd ../worlds
echo "export GAZEBO_RESOURCE_PATH=$(pwd):${GAZEBO_RESOURCE_PATH}" >> ~/.bashrc
source ~/.bashrc
#install bluerov2 simulation
cd ../../catkin_ws_bluerov/src
git clone https://github.com/patrickelectric/bluerov_ros_playground 
cd bluerov_ros_playground
source gazebo.sh
cd ../../../freebuoyancy_gazebo/build
echo "export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:$(pwd)" >> ../../catkin_ws_bluerov/src/bluerov_ros_playground/gazebo.sh
cd ../../catkin_ws_bluerov/src/bluerov_ros_playground
echo "source $(pwd)/gazebo.sh" >> ../../devel/setup.bash
cd ../..

source ~/.bashrc
catkin_make --pkg bluerov_ros_playground
source devel/setup.sh
cd ..
#Add ardupilot full
git clone https://github.com/ArduPilot/ardupilot.git
cd ardupilot
Tools/environment_install/install-prereqs-ubuntu.sh -y
. ~/.profile
source ~/.bashrc
cd ../catkin_ws_bluerov/src
#Add mavros
git clone https://github.com/kdkalvik/bluerov-ros-pkg.git
cd ..
catkin_make
cd ..
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
chmod +x ./install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh


#Install Mavros non binary - currently unsure if this is necessary
#cd catkin_ws_bluerov
#wstool init src
#rosinstall_generator --rosdistro melodic mavlink | tee /tmp/mavros.rosinstall
#rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall
#wstool merge -t src /tmp/mavros.rosinstall
#wstool update -t src -j4
#sudo apt-get install python-rosdep
#sudo rosdep init
#rosdep update
#rosdep install --from-paths src --ignore-src -y
#catkin_make_isolated


#Seperately, you need to install and setup Ground Control
#https://docs.qgroundcontrol.com/en/getting_started/download_and_install.html
#right click, save as the QGroundControl.AppImage
#chmod +x QGroundControl.AppImage
#./QGroundControl.AppImage
#add a UDP port 14552 under comlinks
