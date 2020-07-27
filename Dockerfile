FROM ros:melodic
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full \
    ros-melodic-mavros \
    ros-melodic-mavros-extras \
    ros-melodic-joy \
    git \
    python-pip -y \
    mesa-utils
    #gstreamer stuff

WORKDIR /usr

COPY start_simulation_environment.sh .

COPY install_gazebo_bluerov_tools.sh .