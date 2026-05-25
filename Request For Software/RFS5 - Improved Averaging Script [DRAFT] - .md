# Request for Software: Improved Averaging Script

## **IMPORTANT NOTE**

Do NOT begin to work on this without prior leadership authorization first and external approval of your choice of algorithm!


## What

- A program to average a fuzzy pointcloud into something easier to read and analyze



## When

- Must be finished... sometime



## How

- Write this in Python. 

    - It's almost better for it not to exist than for the majority of it to be written in Bash.

    - Use os.system() etc if you absolutely must

    - Stick to standard or very very well-known and widely-supported libraries if possible

- Must be CLI initially (no graphical interface until everything is working!)

- Must be executable (the tool you want is `chmod +x`)

-  Extra Requirements: It's a direct data-analysis algorithm. Therefore: 

    - No AI/LLMs on this one.

    - everything must be human-written and human-understood

    - Everything must be documented for a scientist to read it

    - Ideally, there should be a mathematical description of the algorithm implemented in an ALGORITHM.md file



## Compatibility

This must interface with:

- Humans (see "Interface", below)

- Potentially a bash-based workflow automation script

This code must run on:

- Ubuntu 24.04

It would be nice if this code ran on:

- Ubuntu 20


## I/O Specification

Must import ASCII-format Stanford .ply file as exported by CloudCompare

Must export ASCII-format Stanford .ply file as imported by CloudCompare


## Interface

Here is how this package will be used:

`cd ~/wherever/`

`./avg_pointcloud.py my_ASCII-based_pointcloud.ply [--optional-extra-params]`



 ## Detailed Specification

### Current Averaging Script

The current averaging script (GDrive://LiDAR/Testing Averaging Functions 2024/averaging_function_Johannes.py) edits an extant pointcloud this way:

1. It divides the x and y coordinates of each point by a given constant, rounds the coordinates to the nearest integer, and multiplies the x and y
coordinates by that constant again. This has the effect of moving all dots within a given small square in the x-y plane into the vertices of 
those squares. In other words, it turns something like this top view:

______________________________________________________
    . ... .. .. 
    ... . .. . . 
     . ..     ..                        y
    . . .     .                         |
     .. . . . ..                        |_____ x
______________________________________________________

into this:

______________________________________________________
    .  .  .  .
    .  .     .                          y
    .  .     .                          |
    .  .  .  .                          |_____ x
______________________________________________________

2. It averages all the points in a given column along the Z axis, and replaces the column with a point at the average Z-position. 
For example, this side view would be transformed in the following way:

______________________________________________________
    .   
    ...   .. .  
    . . . .    .                      z
      . ...    .                      |
       ...     .                      |_____ x
______________________________________________________

______________________________________________________
       
    ..     . .  
      .   .                           z
        ..     .                      |
       .                              |_____ x
______________________________________________________

This method works really well until you get things like the now-infamous arch dataset, which looked something like this:

______________________________________________________
       
          ..... 
        .  . .  .   
       .  .    . .                    z
      .  .      . .                   |
    ..................                |_____ x
______________________________________________________

The horizontal averaging bit worked fine, but instead of representing an arch, Johannes' Averaging Script averaged the Z axes 
and made a bump:

______________________________________________________

        ........                      z
      .          .                    |
    ..             ..                 |_____ x
______________________________________________________

This, obviously, confused the volume algorithms!

This RFC is requesting an improvement upon this current script. Unusually for an RFC, there are actually multiple ways of going about
this which I think are worth pursuing, in order to determine which works best by trying them all. This RFC may therefore be split into
may more RFCs later, or it may be simply assigned to a lot of different people. For now, if you decide to implement one of these, take
your pick, and leave a note in this Markdown file by the heading of the one you're doing, saying that you're working on it. Remember to get leadership approval before you clock in to work on this project for the first time.

### Averaging by Trimming Outliers

The thought behind this one is getting rid of things that are far away from the surface while not altering things that are close to the surface. It might be more useful as a first step, after which other averaging functions are applied. The idea is to divide the data into very thin columns of infinite height. Then, find the mean of the Z-coordinates of all the points, and delete all points that are more than n standard deviations from the mean (where n is an experimentally determined number). This could be repeated many times over in succession. 

The base asumption behind this one is that many vertically-overlapping points are caused by IMU error, which might cause a portion of ground
scanned in one frame to be placed at a slight angle to a second scan-frame of the same piece of ground taken from a different position. This is depicted in a slightly melodramatic way here: 

______________________________________________________
       
                          .               
                      .
                  .                   z
              .                       |
    ..........................        |_____ x
        .
    .
______________________________________________________

The theory, then, is that the true ground is the ground that is around the intersection of these two frames--that is, the area with the greatest
density of points. Trimming out points far from the intersection is likely, under this theory, to improve the surface accuracy.



### Averaging by Distortion Towards the Mode

This idea also relies on dividing the data into very thin columns. Instead of the mean, though, it uses the mode–the z coordinate which appears most often in the column (the idea being that this is most likely to be the surface). It may be necessary to count anything within n of a given number to be equal to that number for this purpose. Then, points are translated differing distances based on their distance from the mode. So, if a given point is 100 meters from the mode, its Z coordinate might be multiplied by 0.01 (making its Z much smaller), while a point 1 meter away from the mode might only have its Z coordinate multiplied by 0.5 (not affecting its Z coordinate much). **NOTE!** This will produce very strange
and twisted results if the true ground level is not near Z=0! You may need to compensate for this by temporarily adjusting your coordinate axis to be closer to the mode.

### Slicing by Cuboid Density

This one also relies on the idea that more points will be closer to the surface than further from it. Divide the whole cloud into cuboids of square base, probably slightly taller than they are wide and long. Then simply delete the contents of any cuboids which contain less than n points. This idea would work wonders on things like bushes, the shade-cloth, and leaves. It might be a good pre-processing idea. The cuboids would need to be pretty small...

### Voxel Averaging

This one divides the whole cloud into little cubes. Then, it does the same thing as Johannes Averaging, except that instead of averaging
the Z of a whole column, it just averages the Z of the cube. 

### Fill In Your Own Averaging Algorithm Idea: _______________


Any final averaging script will probably be a blend between these methods, but these are all the ideas I've heard so far that I think I'm worth
pursuing at the moment. (If I haven't mentioned your favorite method, send me an email and I'll probably add it in)



## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-05-25 7:25 PM Antalya Time
