# Idea: Automatic Shadecloth Trimmer

## What

I have this idea for a Python script that automatically detects and deletes the shadecloth from an ASCII-formatted .ply file.

## How

The shadecloth is unique among the data in that it is a very thin layer of points. It has a largely uniform thickness throughout, and is surrounded above and below by empty space. I think this could be used to detect the shadecloth.

## Draft Program Outline

1. Input Section: 
    - Import libraries for reading ASCII plys (see averaging scripts for code)
    - Read the ply into numpy arrays (better than lists, they're faster)
2. Shadecloth Detection Section
    - Detect which points are part of the shadecloth by the following criteria:

        a) A part of the cloth should have a cluster of points in a wide, flat cylinder all around it (eg. a leaf should not trigger it, nor should a rock, since that rock forms a hollow shell)

        b) A part of the cloth should not have many points above or below it for a very wide space (+/- 0.5m might be a good place to start?). NOTE! If this criteria is used, this script would need to be run _before_ averaging.
    
    - Add these points to a list or smth 

3. Shadecloth Removal
    - Locate all the points identified as "shadecloth" and remove them from numpy array

4. Export
    - Export the numpy array as an ASCII ply again (again see averaging scripts), properly renamed according to convention

## Edits

This idea was drafted by A. Baker on 2026-05-25


## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


