# Request for Review 9 - grabproc

## What
- A new script to automatically move data from the RPi to the G16 and (optionally) SLAM it


## Where

- The code is in the ingenium_cartographer repo on branch "rfs-9-grabproc.sh"
    * Note that I merged branch rfs-8-SLAM-tuning into it. This RFR does not cover that branch
    * Note that I developed parts of rfs-10-installer-refactoring at the same time to integrate smoothly with this code when they are both merged

## When

- Started 2026-07-22

- Finished 2026-07-25

## Relevant Documentation

- I wrote comments in the code and upwards of 90 commit messages

- See my daylogs between the start and the finish dates here https://docs.google.com/document/d/1JhafbNM1u-hvyzSzuAXH5VkEh4kxjw0lRc52SPb9AgU/edit

- The Request For Software that specifies what this code needs to do is located at RFCS/Request For Software/RFS9

## Criticality/Urgency

- Urgency: Low. This is a convenience. But also, it's very tightly integrated with a lot of urgent things, so it had probably better be merged into main soonish or we'll risk bit rot

- Note that since this branch is forked from rfs-10-installer-refactoring (one minor commit after the existing PR to merge it into main), RFR10 should be completed and--critically--merged into main _before_ this is merged into main. Doing so will save a LOT of git-related grief!

## Testing Protocol

1. Set up 2 WSL systems running Ubuntu 24.04 (a main device and an RPi would also work)
    * Use the --name flag in the Powershell to install two distros of the same type
    * One of the two--and there's no knowing which one--will be able to SSH into the other, and the other will only be able to SSH into itself. Figure this out and don't get the two confused (I recommend `touch`ing notes to yourself in ~). Run DAI on the one that can SSH into the other, and RDAI on the one that can only SSH into itself
    * Alternatively, just get a normal "main" device and an RPi. Run DAI and RDAI anew on each
2. On the "RPi", run record.sh a couple of times. Mess with all the parameters as you please. 
3. On the "G16" (or main computer, or main-computer-emulating WSL instance) run `grabproc.sh` with appropriate parameters. If on WSL, you'll need to override the ip address, since our hotspot-generating code doesn't work on WSL and the IP address will almost certainly not be "10.42.0.1". If on actual bare-metal hardware, you should try it with the default settings (omitting the --ssh param entirely)
4. Verify that it complies with the RFS. Note that in a few cases I have intentionally overridden the RFS becuase of new things I have learned about, for example, CLI conventions on Linux. In these instances I have left comments in the relevant parts of the code. 
5. Also verify that my code is readable and adequately-documented. 

## Notes

- Remember, IP addresses in WSL are weird

- `grabproc.sh` will almost certainly fail to run on a non-updated system. Use the install.sh file at https://github.com/ingenium-lidar/ingenium_cartographer/blob/rfs-10-installer-refactoring/install.sh (it's self-documenting--run it with any invalid parameters or no parameters at all and it will print its own documentation) to run DAI and RDAI, since they have been updated to include dependencies that grabproc needs. Any attempt to run it on systems installed from the `main` branch as it currently stands will likely fail. 

## Reviews

I have reviewed this code. It complies with all conditions set out in the initial Request For Software, and is well documented. It complies with all test cases when run on a standard-OS LiDAR computer with no packages installed. I certify that I believe it to be compliant with the AI Policy. 

I certify that I have completed the full peer-review checklist.

I certify that this review is, to the best of my knowledge, complete, and accurately represents the state of the code at the time of review.


Signed J. Smith, 2029-04-02 10:20 AM