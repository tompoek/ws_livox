set -e

. install/setup.bash

(ros2 launch fast_lio mapping.launch.py config_file:=avia.yaml > fastlio.log 2>&1 &) &
sleep 10
fast_lio_pid=$(ps -ef | grep fastlio_mapping | grep -v grep | awk '{print $2}')
rviz2_pid=$(ps -ef | grep rviz2 | grep -v grep | awk '{print $2}')

ros2 run livox_lidar_converter lidar_converter &
sleep 5
lidar_converter_pid=$(ps -ef | grep lidar_converter | grep -v grep | awk '{print $2}')

ros2 run ground_filter_pkg ground_filter_ransac &
sleep 5
ground_filter_pid=$(ps -ef | grep ground_filter_pkg | grep -v grep | awk '{print $2}')

ros2 bag play simple/ --remap /livox/lidar:=/livox/lidar_pointcloud2
sleep 10 # optional: wait for 10 secs for screen recording / snapping

kill $ground_filter_pid $lidar_converter_pid $rviz2_pid $fast_lio_pid
