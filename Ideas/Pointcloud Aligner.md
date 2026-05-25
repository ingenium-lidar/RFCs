# Idea: Automatic Pointcloud Translator-Aligner

## What

Currently, LiDAR operators spend a lot of time aligning pointclouds with generic CloudCompare transform tools. It would be nice to automate this.

## How

CloudCompare has a decent CLI (used in main/subtract.sh of ingenium_cartographer), and if I rememeber right, it has a Python API as well. These could be used to do the appropriate adjustments.

Failing that... this isn't necessarily a mathematically difficult task. It's a bit of vector math, but nothing out of the capability of an undergrad who can consult with math profs. It could probably be done with NumPy. 

## Draft Program Outline

There should be two things this program does. 

1. The first thing should be a generic xyz translation. A normal georectified pointcloud is aligned to an Israeli reference standard based (if I remember right) somewhere near Jerusalem. This means that the (x, y,z) triples in the pointcloud are very very large, since they represent distance in meters from Jerusalem (which is quite a ways). CloudCompare processes more slowly when dealing with numbers that large, so to accelerate things, the LiDAR operator usually knocks a couple orders of magnitude off each number by doing a translation of the pointcloud. You move it closer to Jerusalem, do your computationally intensive tasks like rotating the cloud, and then move it back to Tel Shimron by translating it the same amount as before, just in the opposite direction. 

    - This translation distance should be hard-coded and never varrying. It should not change between different runs of the script. Pick a large integer and stick to it--you don't need to be precise

    - You can get at some reasonable values by opeing up a pointcloud labeled GEO (which means georectified) and picking a few points to look at. As long as you're moving meaningfully closer to the origin, you're good. I remember typing a lot of 0s. 

    - The script should have one mode for doing a transformation, and a different mode for undoing that same transformation. That's why I want to hard-code an integer transform. DON'T PARAMETERIZE THAT. You will confuse EVERYONE.

2. The second thing this program should do will be harder. In CloudCompare, if you get two pointclouds close enough to each other, there's a tool that basically says "assume these pointclouds represent the same surface. Move this one to align best with that one." We use this in lieu of "pizza oven" alignment techniques most of the time because it simply saves so much time during the working day. You can find references for how we do this by looking through Google Drive:/"Instructions and Manuals/Whole System Manuals"/ Make sure to specify in the docs which is the "reference file" and which is the "file to be aligned".

## Implementation Notes

- Make this a CLI. You can easily add a GUI on top of a CLI later, but it's much harder to add a CLI to a GUI. 

## Resources

https://docs.google.com/document/d/1_aagaY8-daK5KEAIQByOfKIhNP-RCbS_8k6GSUGKtQU

## Edits

This idea was drafted by A. Baker on 2026-05-25


## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


