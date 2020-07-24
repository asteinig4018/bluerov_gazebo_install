#Dockerfile
#requires startup script in the same folder

FROM ros:melodic
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full \
    ros-melodic-mavros \
    ros-melodic-mavros-extras \
    ros-melodic-joy \
    git
    #gstreamer stuff

#go to /usr directory
WORKDIR /usr
RUN mkdir -p bluerov_simulation/catkin_ws_bluerov/src

#enter this directory
WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov
RUN catkin_make

WORKDIR /usr/bluerov_simulation
RUN git clone https://github.com/bluerobotics/freebuoyancy_gazebo.git

WORKDIR /usr/bluerov_simulation/freebuoyancy_gazebo
RUN mkdir build

WORKDIR /usr/bluerov_simulation/freebuoyancy_gazebo/build
RUN cmake ../
RUN make

WORKDIR /usr/bluerov_simulation
RUN git clone -b add_link https://github.com/patrickelectric/ardupilot_gazebo.git

WORKDIR /usr/bluerov_simulation/ardupilot_gazebo
RUN mkdir build

WORKDIR /usr/bluerov_simulation/ardupilot_gazebo/build
RUN cmake ../
RUN make
RUN echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc

WORKDIR /usr/bluerov_simulation/ardupilot_gazebo/models
RUN echo "export GAZEBO_MODEL_PATH=$(pwd)" >> ~/.bashrc

WORKDIR /usr/bluerov_simulation/ardupilot_gazebo/worlds
RUN echo "export GAZEBO_RESOURCE_PATH=$(pwd):{GAZEBO_RESOURCE_PATH}" >> ~/.bashrc
RUN source ~/.bashrc

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov/src
RUN git clone https://github.com/patrickelectric/bluerov_ros_playground

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov/src/bluerov_ros_playground
RUN source gazebo.sh

WORKDIR /usr/bluerov_simulation/freebuoyancy_gazebo/build
RUN echo "export GAZBEO_PLUGIN_PATH=${GAZBEO_PLUGIN_PATH}:$(pwd)" >> ../../catkin_ws_bluerov/src/bluerov_ros_playground/gazebo.sh

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov/src/bluerov_ros_playground
RUN echo "source $(pwd)/gazebo.sh" >> ../../devel/setup.sh

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov
RUN source ~/.bashrc
RUN catkin_make --pkg bluerov_ros_playground
RUN source devel/setup.sh

WORKDIR /usr/bluerov_simulation
RUN git clone https://github.com/ArduPilot/ardupilot.git

WORKDIR /usr/bluerov_simulation/ardupilot
RUN Tools/environment_install/install-prereqs-ubuntu.sh -y
RUN source ~/.profile
RUN source ~/.bashrc

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov/src
RUN git clone https://github.com/kdkalvik/bluerov-ros-pkg.git

WORKDIR /usr/bluerov_simulation/catkin_ws_bluerov
RUN catkin_make

WORKDIR /usr/bluerov_simulation
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
RUN chmod +x ./install_geographiclib_datasets.sh
RUN sudo ./install_geographiclib_datasets.sh

COPY start_simulation_environment.sh .

