# Request for Software: Configuring RPi_Network_Config.sh to Run Automatically After Reboot

## What

- After RDAI runs, it reboots. There is a further script in ingenium_cartographer/cartographer_config called RPi_Network_Config.sh that needs to be run immediately after RDAI reboots. There should be a way to do this automatically, and build that functionality into RDAI.



## When

- Should be finished before 2027-04-1



## How

- Must be written in Bash

- Must be triggered by RDAI




## Compatibility

This must interface with:

- Nothing.

This is an absolute. This script may not interact with humans, or with any human-triggered scripts except RDAI. 



## Interface

Here is how this package will be used:

```
cd ~/Documents/GitHub/agent_scripts
./RPi_post-reboot_installer.sh
reboot
```

OR

```
[Insert your code here]
reboot
```



 ## Detailed Specification

 When run, the program must configure *something* such that, after RDAI causes the system to reboot, `ingenium_cartographer/cartographer_config/RPi_Network_Config.sh` runs. 
 This MUST only happen once, because there's another reboot command at the end of RPi_Network_Config.sh, so if whatever you write doesn't undo itself, the RPi will be in an infinite loop of network configuration. If this happens, you have failed. 


 You may edit `RPi_Network_Config.sh` and RDAI to accomplish this if you wish. 

 Possibilities:

 - A cron job that disables itself

 - You could append a line to the ~/.profile file which runs a script to trigger the relevant file and then removes itself from .profile

 - Anything else that does the job

 Blocks:

 - You can't do this with ~/.bashrc because that doesn't work until someone SSHs in

 - It can't reboot infinitely

 -  At the end of this, all system settings, configs, etc, must be the same as they were before.

 - Must not edit systemd unless you already have extensive experience with it. It's too easy to break something really important.


## RTFMs

The following concepts are relevant to this work:

SSH, Ubuntu Server, Networking, bash, bash scripting, shebang, cron, bashrc, systemd, .profile file, installer scripts

The dev should review any concepts with which they are not familiar. 


## Peer Review

One person should peer review the finished software to verify that it complies with this RFS and that it does not cause infinite reboot when the current RPi OS is wiped, replaced by a clean Ubuntu 24 Server installation, and RDAI is run on it (suggest via install.sh)

## Signed

This Request for Software was put out by A. Baker, assistant software architect. Email him with any questions.

Drafted 2026-06-02 16:25 Antalya Time
