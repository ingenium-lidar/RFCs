# Error Logging in DAI and RDAI

## NOTICE: THERE IS AN ACTIVE REQUEST FOR REVIEW RELATED TO THIS FILE

## What

- A refactoring of Default_Apps_Installer.sh and RPi_Default_Apps_Installer.sh to produce error log files related to each step of the process



## When

- Must be finished never, but it will make life easier for the next person who has to use one of these.



## How

- Must be written in Bash

- All necessary components must be installed by DAI or RDAI, or built into them. 




## Compatibility

This must interface with:

- Humans (see "Interface", below)

- An automated checking script

This code must run on:

- Ubuntu 24.04



## Interface

It should save error to ~/Default_Apps_Installer.log or ~/RPi_Default_Apps_Installer.log.
These paths should be printed out by DAI or RDAI at the end in bright colors to inform the user of their existence



 ## Detailed Specification

This program should log success or failure, including process error codes/output in  case of error, for every discrete task. 

### Apt/Snapd-Installs and Similar

The program should log which installer is being run, which package it is attempting to install, whether it succeeded or failed (the process exit code), and, if it failed, a detailed log of *why* (everything it spat to the Terminal should be logged).

### Directory/File Creation 

This includes downloading files from the internet, cloning git repos, installing programs like VeloView, etc. You can use if statements to check if given files or directories exist. The checker should make sure files the program was supposed to delete do not exist, and should also check to make sure files and directories it was supposed to create do exist. 

### Computer Configuration Changes

For things like the git config, the desktop background, and the UI edits, the program should check the values of all configuration parameters that were edited to make sure they match the intended values

### Complex Package Installation

For something like ROS or SLAM, run a few tests involving spinning up and cycling down 1 or 2 important components that we use (eg. source jazzy, start 2 nodes, broadcast a topic from ine, and check that the other can read it). Also check things like the jazzy version installed--if that command doesn't return an error, it's a pretty good indication that jazzy is installed. (Note that that node test is an example on their website). 

### Automatic Checker

There should be an executable script (Bash, Python, or whatever--up to you) that can read the error log file, give a summary of everything that went wrong, and point the user to the relevant lines in the log file containing information about errors. Eg. if yamllint failed to install, the program should output a table labeled "failed to install" (or similar), listing "yamllint. Exited with code 3. More details at line 94 of Default_Apps_Installer.log" (or something like that). This should be put straight in ingenium_cartographer--it's not an agent script because it is not intended to be run solely by a different program. 



## Architectural Notes

1. The program should be hypermodular and very functional. Write a function to check if a file or directory exists, and then use parameters passed to the function to determine whether it should check for a file or a directory and where it should look. Then, you can reuse the same function many, many times. 

2. This program should have standardized error formats. You should be able to have one "write error to log file" function, where you pass it all the necessary parameters from any given error log and it can write it to the file in that standardized format. Don't mix and match error output formats between different kinds of tasks! This will make it harder to read by machine and more confusing for the user. 

3. Agent scripts! You should source an agent script right at the top of DAI or RDAI (consider sourcing it straight from the web using curl or similar), and that script should contain every function you'll ever call inside DAI or RDAI. I want this error logging thing to be *very* unobtrusive! Don't clutter up DAI/RDAI too much. After the VeloView install, write a single line of bash that says `check_veloview --params` and move on! Write as little in [R]DAI as possible and as much in your agent script(s) as possible. 

4. Logs must be human AND machine readable! Consider basing your log format of YAML, JSON, or similar--these formats, designed for configuration files, are both very readable by humans and have vast libraries for easy machine parsing. Idea: have a field in each log that's a "0" or "1"--for "success" or "failure". This will make it really simple for a machine to filter out the errors for the user to peruse. 

5. Code re-use. If possible, write one agent script capable of checking both DAI and RDAI. Remember, you can customize the function calls from within those scripts, so the more code you can reuse, the better. This makes it much easier for others to read your code. 


## RTFMs

The following concepts are relevant to this work:

Bash, agent scripts, system architecture, filesystem conventions, log files, JSON, functional programming, DAI, RDAI, YAML, Unix exit codes, numbers as booleans in C-like languages and Bash, installer scripts, apt & snapd, ROS, git and git clone, curl & wget, traversing file system with Bash, Ubuntu 24

The dev should review any concepts with which they are not familiar. 


## Peer Review

Two people should peer review the finished software to verify that it complies with this RFS and does not break or otherwise significantly interrupt the normal function of DAI and RDAI. 



## Signed

This Request for Software was put out by A. Baker, assistant software architect. Email him with any questions.

Drafted 2026-05-29 5:43 PM