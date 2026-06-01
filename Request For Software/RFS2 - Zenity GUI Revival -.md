# Request for Software: Zenity GUI

## What

- Addition of basic GUIs to our current scripts using Zenity



## When

- Should be finished before 2027-05-01



## How

- Must be written in Bash

- Must use Zenity

- Use must be intuitive to an archaeologist with no formal training

- Should interface with the automated SSH script specified in RFS3

- Should interface with the updated `process_bag.sh` (ALERT! API Specification for this does not yet exist -AB 2026-05-20)



## Compatibility

This must interface with:

- Humans (see "Interface", below)

This code must run on:

- Ubuntu 24.04



## Interface

Here is how this package will be used:

A human should be able to run the script (we can arrage a nice clickable .desktop entry later). It should pop up dialog boxes requesting all the information
it needs. and also should pop up status indicators if a part of the script might take a while. It should also report errors in a GUI format.



 ## Detailed Specification

 When run, the program must ssh into the Raspberry Pi at the IP given by the parameter (default to 10.42.0.1). This may be accomplished by interfacing with the code in RFS3.

 The program may assume that the two devices are on the same wifi network (the RPi hotspot), but if they are not, it should remind the user in plain English to connect to the RPi's hotspot

 Once in the RPi, the program should scp all files and directories in [RPi]~/Documents/Data to [User_Device]~/Documents/Data. Then, it should verify that they were all copied correctly.
 (I've heard of something called a hash, or checksum, which might be helpful in verifying this. Look into it) 
 The program should store the names of all of these files and directories copied in file somewhere (file should be readable by both humans and machines. Maybe a JSON?). 
 Maybe a "receipts" directory somewhere? Be creative, and then document what you did. The receipt should be labeled with the date and time of the copy action.

 Once the files have, for certain, been copied correctly, and the receipt has been logged, the program should delete all the files in [RPi]~/Documents/Data. 
 The reason for this is that this way, whenever the end-user runs this script, they know they're processing all the files that havre been gathered since they last ran it, and they also know that they aren't processing or archiving any twice. 

Once the files have been transferred to [User_Device] (the device this script is running on, which you may assume to be Ubuntu 24) and removed from the RPi, the app may sever the SSH connection. (You can also probably just leave it, because I'm pretty sure that it will close when the script exits, but best to check me on that)

At this point, there should be a GUI popup asking if the user wants to SLAM. If the user says "No", you can just close the program (the Bash `exit` keyword is helpful). If the user says "Yes", the program should utilize our consistent and well-defined directory structure to locate and SLAM all relevant .mcap files which were just copied. It should NOT SLAM any files which it hasn't just copied! Use the receipt of transfer for this. :) NB! This API is not well-defined yet. If you get to the point where you need
to implement this and still nobody has defined it, you can write a specification yourself. Just remember to document your work!

## RTFMs

The following concepts are relevant to this work:

Ubuntu 24, bash, bash scripting, shebang, zenity, .desktop files, process_bag.sh, default file systems, ssh, ip addresses [networking], hotdpot, RPi, hash/checksum, JSON, file manipulation with bash, GUI

The dev should review any concepts with which they are not familiar. 


## Peer Review

One person should peer review any GUI and make sure that using it is intuitive and adequately explained within the GUI itself.
During the review process, the author of the code should not speak--they should just hand the computer to the reviewer.


## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-05-20 12:35 PM
Revised --