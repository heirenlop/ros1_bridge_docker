# **ros1_bridge Docker Environment**
This Dockerfile sets up an environment that integrates both **ROS 1 Noetic** and **ROS 2 Foxy**, facilitating communication between the two using the ros1_bridge package.

---
## ** How to use**


(1) Terminal 1: run roscore
```bash
source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash
roscore
```

(2) Terminal 2: run ros1_bridge
```bash
source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
```

(3) Terminal 3: play ros1 bag
```bash
source /opt/ros/noetic/setup.bash
rosbag play <ros1_bag_file>
```

(4) Terminal 4: record ros2 bag
```bash
source /opt/ros/foxy/setup.bash
ros2 bag record -a -o <your_bag_path_to_save>
```

(5) [reference link]([https://](https://github.com/ros2/ros1_bridge))