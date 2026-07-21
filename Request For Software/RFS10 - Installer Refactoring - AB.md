# Request for Software: Installer Script Refactoring

## What

- A program to add additional options to the team's installer scripts, regarding:

    * Whether or not to include GUI scripts

    * Which branch to fetch the various repos from




## When

- Priority higher than SLAM install, because it is necessary to properly test SLAM installation. 



## How

- Must be written in Bash

- Must be able to accept arguments passed via command line

- Must be CLI only (no graphical interface!)



## Compatibility

This must interface with:

- Humans (see "Interface", below)

This code must run on:

- Ubuntu 24.04



## Interface

Here is how this package will be used:

`./install.sh [options]`

- `-h`, `--help` — print usage text, exit 0
- `-v`, `--verbose` — more output  — variable `verbose`, 1 means verbose while 0 means quiet, default to 1, this flag sets it to 1
- `-q`, `--quiet` — suppress non-essential output — variable `verbose`, 1 means verbose while 0 means quiet, this flag sets it to 0
- `-f`, `--force` — skip confirmation prompts
- `--version` — version string, exit 0
- `--omit-gui` — applicable only for DAI. Do not install GUI applications, exit 0
- `--package=` — installer script to run. `--package=dev-jazzy`, `--package=rpi`, etc. 


## Exit Codes

0 means success

1 means general error

2 means invalid argument error


## Detailed Specification

The script must accept all of the above arguments.

The script must not error if any of them are ommitted, except `--package`. If that is ommitted, it should exit 2. 


## Peer Review

One person should peer review the finished software to verify that it complies with this RFS

## Signed

This Request for Software was put out by A. Baker, assistant software architect. Email him with any questions.

Drafted 2026-07-21 12:30 PM
