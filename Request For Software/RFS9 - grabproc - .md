# Request for Software: Automated Data Copier and SLAMmer

## What

- A program to automaticallly move the contents of RPi:~/Documents/Data into G16:~/Documents/Data, verify that this has been done correctly, and (optionally) SLAM all as yet un-SLAMmed .db3/.mcap files in the moved batch



## When

- Should be finished before 2027-05-01 (future architects may opt to deprioritize this)



## How

- Must be written in Bash

- Must interact with our filesystem and other scripts appropriately

- Should ultimately go in ingenium_cartographer




## Compatibility

This must interface with:

- Humans (see "Interface" below)



## Interface

Here is how this package will be used:

```
cd ~/Documents/GitHub/ingenium_cartographer/
./grabproc.sh
```

OR

```
cd ~/Documents/GitHub/ingenium_cartographer/
./grabproc.sh [params]
```

`grabproc.sh` must accept the following arguments:

- `--ssh username@ip_addr`

    The --ssh parameter should specify exactly how `grabproc.sh` is to SSH into the remote device. This should default to "lidar@10.42.0.1", since this is our default username and IP Address for the RPis, but this parameter option should exist in case anyone wants to use grabproc anywhere else. 

    Example param usage: `./grabproc.sh --ssh ubuntu@10.42.0.1`

    You may specify that if the user passes an --ssh parameter, the username@ip string must follow immediately after the parameter, separated by a space, with no other parameters in between. If you script fails because someone passed a different param in between `--ssh` and `username@ip`, that is OK.

-  `-s` or `--SLAM`

    The `-s` flag or `--SLAM` parameter (both should do the same thing) should specify that the program should, after verifying data transfer, run process_bag.sh on each .mcap/.db3 file transferred. If this flag is not present the program should not do this.

    Example param usage: `./grabproc.sh --SLAM` or `./grabproc.sh -s`


- `-h` or `--help`

    The `-h` flag or `--help` parameter should print a helpful user instruction manual about the script and how to use it. When discussing parameters in there, use the same format as in man pages to ensure widest comprehensibility. 

    Example param usage: `./grabproc.sh --help` or `./grabproc.sh -h`

The program must accept any, all, or none of these in any order and process them correctly. The `-s` and `-h` flags should be stackable--ie `-sh` and `-hs` should both work to print help info and SLAM the files, as is standard in CLIs.

Additionally, any parameters that `process_bag.sh` takes in addition to the filepath (see RFS 8) should be accepted by `grapproc.sh` and passed to all SLAM calls if that functionality is requested.

In the event  of an unrecognized param, the program should throw a warning to terminal in a bright color, but should otherwise continue to run as normal without that parameter.


 ## Detailed Specification

 The program must comply precisely with the interface section above. 

 First, the program should SSH into the RPi. You may assume that when grabproc.sh is run, the two are on the same network, and you may throw an error if they are not. It would be kind, in this instance, to insert a reminder to the user to connect to the RPi's hotspot.

 Then, the program should make a list of all top-level directories in G16://~/Documents/Data. They will be formatted as YYYY-MM-DD: for example, `~/Documents/Data/2026-06-11/` . The program should ignore all directories there that do not start with a number, and should also ignore all files that are not directories. The program should save this list as a .txt or .json file (your choice) named "G16-extant-data-files-YYYY-MM-DD HH:MM.txt" (or .json or whatever, with YYYY, MM, DD, HH, and MM replaced by the actual time values when the program is run. These can be obtained via the `date` utility--try `date "+%F %H:%M"`). The program should then SCP this file from the G16 into the RPi, at a location of your choosing. /tmp would probably be fine. 

 Next, the program should examine all top-level directories in RPi://~/Documents/Data, using the same criteria as above (ignore directories without numbers to start their names, etc). The program should make a list of all directories that are _not_ in the data file that was just copied over--this list is the list of data subdirectories that need to be transferred.

 The program should record all these names in "RPi-unique-data-files-YYYY-MM-DD HH:MM.txt" (or .json or whatever, as before) and save that file. Then, it should compress all these folders into .zip archives (do NOT delete the original directories yet! So far we just have these zipped copies lying around). Then, it should create a _hash_ or "checksum" for each zip file, which serves as a unique identifier of that file and a guarantor that it has not been altered. You may use any hash algorithm you please, cryptographically secure or not. We do not especially care in this case. It should append the hash of each file to that "RPi-unique-data-files" file, in such a manner that a human and a machine can easily distinguish which hash algorithm goes with which directory name. To be clear, we're listing the name of the unique directory alongside the hash of the zip file of that directory. 

 Then, the program should scp all of those zip files, along with the "RPi-unique-data-files" file, into G16://~/Documents/Data. It should then find the hash of each of these zip folders _again_--if the hash has changed, it means that the zip file has become corrupted in transit from the RPi to the G16.

 - If the hash has changed, the program should go back, rezip that file on the RPi, rehash it, re-scp it, and check it again. The program should keep on trying this until it works.

 - If the hash that was calculated and recorded on the RPi (as recorded in that "RPi-unique-data-files" file) is the same as the hash that is calculated on the G16 (make sure you use the same algorithm both times!) then the program should unzip that zip file into G16://~/Documents/Data. Then, it should delete the zip archives on both the RPi and the G16, and it may rm -rfd the original data folder on the RPi. Finally, the names of each directory succesfully transferred in this way should be echoed to an invisible file in G16://~/Documents/Data/ called ".transferred-YYYY-MM-DD". Put the name of each transferred directory on its own line in here. This part of the specification is important because it may interact with the "Data Backups to Box" Idea if/when it is written into an RFS. 

 - Nextm if the `--SLAM` parameter was passed, the program should now examine the data folders it copied (which should be in alignment with the filestructure produced by `record_to_bag.sh`). If there are any .mcap/.db3 files inside with the label "RAW" which do not have a matching file with the label "RAW-SLAM", the program should run `process_bag.sh` on them with the appropriate parameters as needed. Consult the "RPi-unique-data-files" file to determine which directories should be examined and potentially SLAMMed in this instance. Do not examine or SLAM any directories not copied in the current operation.

 - Finally, the script should clean up the "RPi-unique-data-files" and "G16-extant-data-files" files, but it should leave the ".transferred" files and other data files alone--those are a permanent record. 


## RTFMs

The following concepts are relevant to this work:

SSH, Ubuntu Server, Networking, bash, bash scripting, shebang, Ubuntu Desktop, SCP, hash/checksum, zip, echo to files, `process_bag.sh`, `record_to_bag.sh`

The dev should review any concepts with which they are not familiar. 


## Peer Review

Two people should peer review the finished software to verify that it complies with this RFS.

## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-06-11 12:14 Antalya Time


--

An early draft of this was my very first Bash program, once upon a time!!! _So_ excited to see it implemented :) 

\- the author