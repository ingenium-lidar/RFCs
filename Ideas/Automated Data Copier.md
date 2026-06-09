# Idea: Automated SSH & Copying of Info from RPi

## What

Let's integrate an SSH and an SCP etc to automaticallly move the contents of RPi:~/Documents/Data into G16:~/Documents/Data

## How

SSH and SCP are old hat and well documented. The novel bit will be figuring out how to verify that the data made it across the connection uncorrupted...

## Draft Program Outline

1. SSH into RPi

2. Hashsign each folder in RPi:~/Documents/Data

3. SCP them into G16:~/Documents/Data

4. Verify on G16 that they are uncorrupted via hash signatures

    - Potentially hash the hashfile to be 1000% safe

    - If corrupted, loop 3 & 4 until 4 returns true

5. Once verified that they have made the transfer safely, remove all files in RPi:~/Documents/Data that were safely transferred

NOTE! Deep familiarity with naming conventions and our filesystem will be required

## Edits

F. Kriner had this idea first. 
This idea was drafted by A. Baker on 2026-06-09

## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


