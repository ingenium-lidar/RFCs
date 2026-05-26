# Idea: Automatic Tree Remover

## What

I have this idea for a Python script that automatically detects and deletes trees from an ASCII-formatted .ply file.

## How

Unlike the surface of the dig site, trees are very tall and comparatively thin. Additionally, they have leaves, which 
show up in LiDAR scans as floaty fuzzy clouds high above the surface of the dig where most points are. I hypothesize that
these two attributes (which are unique to trees in our context) might be sufficient to remove trees automatically.

As a data-processing algorithm, this should be done without AI, and every point that is removed should be added to a separate .ply file,
so that the user can compare the two pointclouds overlaid in CloudCompare to visually determine whether anything that's not a tree has
been accidentally removed. 

## Priority

Very very low. This is a task that's hard for machines, easy for humans, only occasionally applicable, and not remotely urgent. It's a
cool feature to add on later should we somehow have a surplus of eager programmers.

## Draft Program Outline

1. Input Section: 
    - Import libraries for reading ASCII plys (see averaging scripts for code)
    - Read the ply into numpy arrays (better than lists, they're faster)
2. Tree Detection
    - Detect which points are part of the tree by the following criteria:

        a) A leaf should be separated by great perpendicular distance from the plane of the surface (which can be detected according to its higher density than the other places). A leaf will also be part of a very very low-density voxel. Both of these criteria should be
        enforced simultaneously by the algorithm. 

        b) A trunk should be a vaguely cylindrical hollow shell that significantly skews the mean Z of the cloud higher all on its own. Its Z 
        coordinates, in other words, will be really major outliers--once you remove them, the average Z of the cloud should be pretty darn close to the average Z of the surface (which can be determined, for algorithm verification purposes, by manual pointcloud trimming)
    

3. Tree Removal
    - Remove these points from the original np array and add them to a new np array

4. Export
    - Export both numpy arrays as an ASCII ply again (again see averaging scripts), properly renamed according to convention

## Edits

This idea was drafted by A. Baker on 2026-05-26

## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


