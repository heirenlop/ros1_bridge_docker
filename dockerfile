# ==========================================================
# Dockerfile
# ==========================================================
# Title       : ros1_bridge Dockerfile.
# Description : A Dockerfile that sets up a ros1_bridge environment based on ROS 1 Noetic and ROS 2 Foxy:
# Author      : [lijialu]
# Created on  : [2024-12-16]
# Updated on  : [2024-12-16]
# ==========================================================

# Use the official ROS 2 Foxy image as the base image
# 使用官方 ROS 2 Foxy 镜像作为基础镜像
FROM ros:foxy

# Set environment variables to avoid interactive prompts during installation
# 设置环境变量，避免交互式安装中的提示
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS1_INSTALL_PATH=/opt/ros/noetic
ENV ROS2_INSTALL_PATH=/opt/ros/foxy

# Add ROS 1 Noetic repository and its GPG key
# 添加 ROS 1 Noetic 的软件源和 GPG 密钥
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --no-tty --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install ROS 1 and necessary dependencies
# 安装 ROS 1 和必要依赖
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    python3-colcon-common-extensions \
    python3-rospkg \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
# 设置工作目录
WORKDIR /root

# Create a workspace and clone the ros1_bridge repository
# 创建工作空间并克隆 ros1_bridge 仓库
RUN mkdir -p ros1_bridge_ws/src && \
    cd ros1_bridge_ws/src && \
    git clone -b foxy https://github.com/ros2/ros1_bridge.git

# Build the ros1_bridge workspace
# 构建 ros1_bridge 工作空间
RUN /bin/bash -c "source $ROS1_INSTALL_PATH/setup.bash && \
    source $ROS2_INSTALL_PATH/setup.bash && \
    cd /root/ros1_bridge_ws && \
    colcon build --symlink-install --event-handlers console_cohesion+"

# Add ros1_bridge environment setup to bashrc
# 在 bashrc 中添加 ros1_bridge 环境配置
RUN echo "source /root/ros1_bridge_ws/install/local_setup.bash" >> ~/.bashrc

# Set the container's entrypoint
# 设置容器入口点
ENTRYPOINT ["/bin/bash", "-c", "source /root/ros1_bridge_ws/install/local_setup.bash && /bin/bash"]
