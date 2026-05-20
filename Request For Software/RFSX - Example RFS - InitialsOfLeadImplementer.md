# Request for Software

## What

- A program to automate SSHing into an RPi



## When

- Must be finished before 2025-02-24



## How

- Must be written in Bash

- Must be able to accept arguments passed via command line, for automation purposes

- Must be CLI only (no graphical interface!)



## Compatibility

This must interface with:

- Humans (see "Interface", below)

- An automated startup script (specification is in Request For Specification #94642: Startup Scripts for Termux on Android Phone)

This code must run on:

- Ubuntu 24.04

- Android 13 (via Termux)



## Interface

Here is how this package will be used:

### Ubuntu Terminal (human use): 

Simply running the script should connect by default to ip 10.42.0.1

`./rpi-connect.sh`

The script should also be able to accept an ip address as an argument.

`./rpi-connect 10.42.0.2`


### Termux script (automated): 

When run in the Termux environment, no human will be interacting with it. The syntax should be:

`./rpi-connect.sh`

It should output errors, if any, to a file in the same directory called
 `rpi-connect.log`



 ## Detailed Specification

 When run, the program must ssh into the Raspberry Pi at the IP given by the parameter (default to 10.42.0.1). 

 The program may assume that the two devices are on the same wifi network (the RPi hotspot)

 On Termux, when the user opens the app, they should SSH into the RPi immediately.

On Ubuntu, this behaviour should not happen. (The dev may need to write a cron job or similar for Termux specifically. If the dev does so, there should be included a script which can be run once to set up the cron job)

## Signed

This Request for Software was put out by A. Baker, assistant software architect. Email him with any questions.

Drafted 2026-03-30 9:45 PM
Revised 2026-03-30 10:13 PM