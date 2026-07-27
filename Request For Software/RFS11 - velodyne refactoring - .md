# Request for Software: Refactoring Velodyne Transformer Code

## What

- Let's move the code that converts /velodyne_packets to /velodyne_points from `process.sh` to `record.sh`

- Let's also move all the topic renaming stuff to `record.sh` too!

## Why

Currently, our .mcap files contain data of the names /imu/gx5/data and /velodyne_packets. However, /velodyne_packets has a proprietary format that nobody else can read. We're already converting it to the PointCloud2 format (that everyone can read) in process.sh, but if we do that _before_ we put it in the .mcap, then our data files are interpretable by everyone in the world, whether or not they have this velodyne converter installed or not! This will also improve the longevity of our data systems, since the PointCloud2 format, being standardized by something as large as ROS, is likely to remain readable for a LOT longer than a now-defunct company's packet dumps. 

Along those same lines, while we're moving code over, let's put topic renamings in `record.sh` too--that way, as long as we pick sensible topic names, it will be easier to interpret our data and what's inside it!

## When

- We should do this before we spend a summer taking data with the new system. 


## How

- Literally just cut and pasting code from `process.sh` over into `record.sh` and making sure the dependencies for that code are in RDAI (I think they're all in IJ, which is run by RDAI, but it can't hurt to check!)

- Rename the LiDAR topic that leaves the transform node and enters the .mcap to /input_cloud, /velodyne_points, /points_raw, or something like that

- Rename the IMU topic to a simple /imu

## RTFMs

Info on the drivers: https://docs.google.com/document/d/15xIyGQc6kWtry4_2FnW8B0W0xo9MxjumuvBmkaIHdJs/edit?tab=t.0#heading=h.ah3gek9xt7gk

More about our specific SLAM and the topics involved: https://docs.google.com/document/d/1HL24Ec4AUhyH0FEM-7lV_DmCMBd_8K3ZKQzwy4NYEMM/edit?tab=t.5x4zg4nogoi4#heading=h.mewmbcw4p07t

`ros2 node list`, `ros2 topic list`, `ros2 topic info`, and `ros2 topic echo` are your friends here!

## Peer Review

Not strictly necessary on this one, as long as the code works. If you're new to the team, though, get someone to do a review for you so you can learn how the review process works!

## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-07-27 1:28 PM UTC+3

Revised 2026-07-27 1:36 PM UTC+3 A. Baker
