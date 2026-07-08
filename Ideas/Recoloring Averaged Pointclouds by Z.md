# Idea: Recoloring Averaged Pointclouds as a Function of Z

## What

Let's add some code into our averaging scripts that recolors each point as a function of its Z position.

## Why

Normally, the point colors represent the density of the points in a particular area--light green is higher density, dark blue is lower density.
However, after our averaging script runs, this metric no longer makes sense, since the density is thereafter largely uniform and wholly binary--
voxel point density is always either 1 or 0. Because of this, historically, the averaging script has discarded point color data. I propose 
adding code to our averaging script so that every point recieves a color along a gradient, according to its z position. This would greatly aid in
visualizing the shape of the pointcloud as a whole by increasing visual contrast between what are otherwise some white points and some more white 
points.

## How

Pick a color gradient that works as RGB. Write 3 mathematical functions--one each for R, G, and B, that take an integer "Z" (which should be normalized along a 0-100 range, or something) and spits out the specific R, G, or B value associated with that integer. 

Then, find the max and min Z in the pointcloud and set "min" to "0" and "max" to "100". Use this and rounding to map each Z point onto an appopriate RGB pair. Optimize the 
numpy side of things heavily--it's built exactly for tasls like this and you should be able to get it done lightning fast. 

## Edits

This idea was drafted by A. Baker on 2026-07-08


## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


