# Request for Software: SLAM!

## What

A program in two parts:

* The first must install a ROS2 Jazzy Jalisco-compatible LiDAR SLAM algorithm without mandatory GNSS input

* The second is a rewritten version of `process_bag.sh`


## When

- Must be finished before 2027-05-01

- This RFS takes priority over all other RFSs. 



## How

- Should probably be written in Bash

- Must be executable

- A call to the installer script should be built into DAI

- Should probably involve an awful lot of git clones into ~/Apps



## Compatibility

This must interface with:

- Humans (see "Interface", below)

This code must run on:

- Ubuntu 24.04 LTS Desktop



## Interface

Here is how this package will be used:

`cd ~/Documents/GitHub/ingenium_cartographer/agent_scripts`

`./Install_SLAM.sh`

AND

`cd ~/Documents/GitHub/ingenium_cartographer`

`./process_bag.sh /path/to/my/file.mcap`

You may include any necessary additional parameters according to the needs of the SLAM that you install.


 ## Detailed Specification


Both programs must run on our G16, on Ubuntu 24.04 LTS

### Regarding Install_SLAM.sh

Our current SLAM is [github.com/rsasaki0109/lidar_slam_ros2](https://github.com/rsasaki0109/lidar_slam_ros2). I encourage you to use this, but I won't require it if you find another SLAM that's easier/works better. 

Try _not_ to install it in a Docker, if you can.

Open issues on rsasaki0109's repo as needed.

Here is how we do git repos:

- If we're working on them/maintaining them, they go in ~/Documents/GitHub/

- If we're using something that someone else is maintaining, it goes in ~/Apps/

If you clone a few git repos, just dump them in ~/Apps/. But if you're cloning a lot of them for this, consider making a new directory at ~/Apps/SLAM/ and putting them all in there

You may assume that this script will only be run by DAI, and never by RDAI. _But_ if you need a dependency `Install_SLAM.sh` should install it, without relying on DAI to do so.



### Regarding process_bag.sh

The program must accept the name of the .mcap or .db3 file as input. Which of these we end up using is up to you. If there is no difference between them, .mcap is _slightly_ safer because of its append-only file structure. 

Inside, the program should use `ros2 bag play ... &` or similar to play the data back from the file passed as an arg. If the SLAM supports it, playback at faster than real time is preferred. First, prioritize accuracy (ie don't accelerate if it would make the output worse) but work the SLAM as fast as it can go without sacrificing quality. 

As soon as the bag starts playing the SLAM should start SLAMming, in whatever way it does. The initial orientation of the puck may be assumed to be vertical (since this is how the IMU initializes, that's how we always hold it). I don't know if the SLAM cares about that, but if it does, now you know. 

Finally, the program should locate the SLAMMed output file. If it is not in a Stanford PLY format (either ASCII or Binary is fine), the program must convert it (losslessly if possible) to that format. It should rename it according to the naming conventions (see below) and move it to the appropriate location in the file system. If the SLAM creates more files than the main data file, you must evaluate them for their usefulness. If they are useful, archive them in the same place as the data file. If they are not useful, the program should automatically delete them. 



## File System Conventions

`record_to_bag.sh` saves files according to this pattern: `~/Documents/Data/$(date +%F)/"$grid_id"_RAW_$(date +%F_%H:%M)`

- All data goes in ~/Documents/Data

- Inside that directory, the subdirectories are labeled by the day on which the data was taken

    * eg ~/Documents/Data/2026-06-11/

- $grid_id is a variable inputted by the user

    * files within are named according to the Grid ID, the date they were taken, and the stage in processing they are in

    * Your script should _preserve_ the original recording timestamp and not change it

    * When your script saves the file, it should be in the exact same place as the file that is being SLAMMEd

        + The name should be the same, except that it should have a different ending and should have `_RAW-SLAM_` instead of `_RAW_`

        + After this, it will be manually converted to  `_RAW-SLAM-CUT_`, then `_RAW-SLAM-CUT-AVG_`, and finally `_RAW-SLAM-CUT-AVG-GEO_`

            - So the final pointcloud file, if it were recorded on June 11th 2026 and depicted Grid 92, might look like: `~/Documents/Data/2026-06-11/92_RAW-SLAM-CUT-AVG-GEO_2026-06-11_10:59` (the redundancy in the date is worth it to keep the exact original time associated with the file)

            - It would be tidier to overwrite "RAW" with "SLAM" rather than appending it as "RAW-SLAM", but I think the pedagogical value of preserving the path through the system that the data takes is worth it in this instance
        
        + It's really important that this SLAM program does this file system manipulation automatically and properly. The best way of ensuring organization is to enforce consistency by automatic script!

## RTFMs

The following concepts are relevant to this work:

SLAM, bash, bash scripting, shebang, Google Cartographer, `process_bag.sh`

The dev should review any concepts with which they are not familiar. 


## Peer Review

One person should verify that the software produced meets all specifications and is fully documented.


## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-06-11 11:13 AM Antalya Time

Revised ---