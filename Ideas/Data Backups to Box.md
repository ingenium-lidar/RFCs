# Idea: Back up ~/Documents/Data to Box periodically

## What

If and only if Dr. Master likes the idea, let's back up ~/Documents/Data to Box periodically

## How

There are a couple of programs related to setting up a Box drive in the helper-scripts repo. The rest is just file system traversal and cp. A lot of that code in helper-scripts could be repurposed for this task. 

## Draft Program Outline

1. Cron job calls script periodically

    - Script compares file names in backup folder and in local data storage (recursive search algorithm)

    - If needed, calls a copier script

2. Copier script moves all new data files over into the appropriate locations in the Box archive

NOTE! Deep familiarity with naming conventions and our filesystem will be required

## Edits

This idea was drafted by A. Baker on 2026-06-09

## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


