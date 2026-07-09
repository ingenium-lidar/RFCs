# Request for Review: RPi Network Config Auto-Run

## What
- Bash script that starts a cron job so that a certain file (RPi_network_config.sh) will run immediately after the RPi reboots.

## When
- Started June 12, 2026
- Finished July 6, 2026

## Relevant Documentation
- In addition to the comments in the code, I wrote a daily log on Google Docs. Here's a link: [Summer 2026 Project Log](https://docs.google.com/document/d/1JhafbNM1u-hvyzSzuAXH5VkEh4kxjw0lRc52SPb9AgU/edit?tab=t.0#bookmark=id.ngmcslb85k6m).
- The Request For Software that specifies what this code needs to do is located at Request For Software/RFS7 RPi Network Config Auto-Run-JD.md
- To test it, you need to run the script 'RPi_Default_Apps_Installer.sh' and ensure that RPi_network_config.sh runs after the reboot.

## Criticality/Urgency

- The RFS7 document stated that this needed to be finished by 2026-08-01.

- One peer review requested by RFS.

## Testing Protocol

0. Read through all of these instructions carefully before trying to follow any of them.

1. Locate a team Raspberry Pi with the new system on it. Extract its SD card

2. Using a PC and the Raspberry Pi Imager tool (cross-platform), wipe the SD card and put a clean Ubuntu 24.XX LTS Server on it

    - You may be able to simply tell the Imager to install Ubuntu 24 LTS Server, and it will wipe it

    - Another possibility is that it will recognize the existence of Server on there already, and try to "optimize" by not deleting any files. 
    if this is the case, you may need to install a different OS (eg. Ubuntu Core) first, in order to wipe the SD card, before then immediately
    reinstalling Ubuntu Server. 

    - Either way, at the end of this process, you should now have an RPi running generic Ubuntu 24 LTS Server, and it should NOT have our system
    installed on it. Verify this carefully. The username should be "lidar", all lowercase, according to team convention. 

3. Connect a monitor and external keyboard to the RPi and boot it up. It will display a wifi login interface (which it MUST have) and then give
you instructions on how to SSH into it. Do so. 

4. Download and run RDAI on it, according to the instructions in the GitHub README (use install.sh with the --rpi parameter). Do the manual installation,
because the handy automatic one points to the default branch, while in this case you have been assigned to examine the RFS7 branch. You may need to manually
type some long URLs. Be very very carefult that you are testing with the appropriate branch or you will find a false negative and have to do this all over again.

5. After it has finished rebooting (which it will do several times) and the rest of the installation is done, verify that RPi_network_config.sh
ran automatically on its own without requiring user intervention. Examine the script itself to see what it's supposed to change, and then verify
that it did actually change it automatically.

6. If it succeeded, you're done. Sign this RFR. If it failed at some point in the process, document exactly what you did to make it break and why what you did broke it.
Return this to the person responsible for this code in a polite email, text, WhatsApp message, or similar. 

## Reviews

I have reviewed this code. It complies with all conditions set out in the initial Request For Software, and is well documented.

I certify that I believe it to be compliant with the AI Policy. 

I certify that I have completed the full peer-review checklist.

I certify that this review is, to the best of my knowledge, complete, and accurately represents the state of the code at the time of review.

Signed [Name], YYYY-MM-DD HH:MM AM/PM
