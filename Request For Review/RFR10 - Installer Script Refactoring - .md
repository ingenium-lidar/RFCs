# Request for Review 10 - Installer Script Refactoring and SLAM Installation

## What
- A complete rewrite of most of our installer scripts
    * install.sh now has a proper CLI
        - Verbosity ranges from 0-2, inclusive
            * 0, ideally, should mean stderr only, but I'm not sure how to force that globally yet
            * 1 is stdout and stderr from processes, but no echoes from us
            * 2 is stdout, stderr, and our explanatory echoes
            * This should apply to all scripts, but doesn't yet include RDAI
        - The --force parameter now controls whether -y flags get added to all the installs
        - The required --package parameter controls what installer script you run
        - the --omit-gui flag should now omit all GUI apps, and also set up a ~/.wslrc file to replace the notify-send function with a windows-compatible one
    * Install_SLAM.sh has been broken into 3 files
        - One runs the other by means of reboot+, a brand new script to reboot and then run another script
        - Beware ~
        - /home/lidar is hardcoded as a user path now. Ideas to fix this are very welcome
        - They're all in ingenium_cartographer/agent_scripts/SLAM/
    * Install_SLAM works consistently
    * The script throws more meaningful errors, including documented exit codes for the first time


## Where

- The code is in the ingenium_cartographer repo on branch "rfs-10-installer-refactoring"
    * Note that I merged branch rfs-8-slam-install into it. This RFR covers both. 

## When

- Started July 21, 2026

- Finished July 21, 2026, about 13 hours later!

## Relevant Documentation

- I wrote comments in the code and upwards of 80 commit messages

- Regarding my work on RFS8, see https://docs.google.com/document/d/1JhafbNM1u-hvyzSzuAXH5VkEh4kxjw0lRc52SPb9AgU/edit?pli=1&tab=t.0#heading=h.xkxmkp27412n

- I wrote RFS10 and finished it all in the space of one frantic day. Here's my daylog for that https://docs.google.com/document/d/1JhafbNM1u-hvyzSzuAXH5VkEh4kxjw0lRc52SPb9AgU/edit?pli=1&tab=t.0#heading=h.ivm5iylhhhlj
    * Realistically, though, this RFR is most of my docs for RFS10

- The Request For Software that specifies what this code needs to do is located at RFCS/Request For Software/RFS8 and also RFCS/Request For Software/RFS10

- My Claude chats are available upon request. 
    * Claude was especially helpful as a syntax checker for obscure bashisms. 
    * Claude was also used to review 16000-line logs and flag errors therein 

## Criticality/Urgency

- Urgency: I mean, it's half the SLAM problem solved...

- This is a highly critical component--installer scripts are at the heart of everything we do.

## Testing Protocol

1. get the correct install.sh file with `wget https://raw.githubusercontent.com/ingenium-lidar/ingenium_cartographer/refs/heads/rfs-10-installer-refactoring/install.sh`

2. `chmod +x install.sh`

3. `./install.sh -p dev-jazzy -b rfs-10-installer-refactoring -f -v --omit-gui 2>&1 | tee ~/default_apps_installer_log.txt`

Test the CLI rigorously to try and make it break

Try to produce syntax errors by various param configs

Verify that it runs correctly on a clean WSL system (remember the username `lidar` is now hardcoded)

Test that the SLAM works (will require some git shenanigans, since DAI will have `ingenium_cartographer` on the rfs-10 branch)

## Reviews

I have reviewed this code. It complies with all conditions set out in the initial Request For Software, and is well documented. It complies with all test cases when run on a standard-OS LiDAR computer with no packages installed. I certify that I believe it to be compliant with the AI Policy. 

I certify that I have completed the full peer-review checklist.

I certify that this review is, to the best of my knowledge, complete, and accurately represents the state of the code at the time of review.


Signed J. Smith, 2029-04-02 10:20 AM