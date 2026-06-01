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
coordinates by that constant again. It puts all points with the same rounded values in a "group" according to somme parameters. If you pass `["x", "y"]` as 
parameters, it groups all the points which have the same rounded_x and the same rounded_y. Then, for each group, it averages all the points in that group into
one point. 

In other words, it turns something like this top view:

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

2. When the grouping parameters are x and y, this has the effect of averaging all the points in a given column along the Z axis, and replacing the column with a point at the average Z-position. For example, this 2-dimensional grid, if grouped by x, would be transformed in the following way:

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

Here is a paste of averaging_function_Baker.py, which is my own annotated version of the current script:


    # Import pandas and numpy, standard scientific data analysis libraries
    import pandas as pd
    import numpy as np



    import_path = "/home/lidar/ingenium_cartographer/labtest5_pointcloud/labtest5.txt"  # file path of the pointcloud.txt file. User edits this manually. (Future optimization: make this file executable and pass this path a CLI parameter)
    export_path = import_path[:len(import_path)-4] + "AVG" + import_path[len(import_path)-4:] # export path is the same as the import path, but with "AVG" before the file extension. So, if the import path is "labtest5.txt", the export path is "labtest5AVG.txt". This is done by slicing the string at the last 4 characters (the ".txt") and inserting "AVG" before that.



    def import_dataframe(full_path):

        # Read the file at the path (an ASCII-format Stanford .ply) as a space-separated .csv. Specify that the file has no header row--it jumps straight into numbers
        csv = pd.read_csv(full_path, sep=' ', header=None)

        # Convert the datato in a Pandas dataframe object.
        df = pd.DataFrame(csv)  

        # Label the df columns. These can now be used in place of column indices.
        df.columns = ["x", "y", "z"] 

        print("DataFrame acquired.")
        return df



    # average the df file in the axis omitted from the axes parameter. Axes should be a list containing some out of ["x", "y", "z"]. Step seems to be a float in meters, over which interval the axis omitted is averaged.
    def get_avg(df, step, axes=[0,1,2]):  
        
        # List of all the columns in the df file.
        cols = ["x", "y", "z"] 
        # Create a new list of headers. This used to be a complicated comprehension, but I didn't consider that additional computation to be time-saving or easier to read than just writing the list
        rounded_cols = ["rounded_x", "rounded_y", "rounded_z"] 

        if (axes != [0,1,2]): # If the axes aren't at the default, assume the user passed a list of column names in string form.
            axes = [cols.index(n) for n in axes] # In this instance, urn the axes list back into column index numbers


        # For each column in cols:
        #    divide the values by step
        #    round the values to the nearest integer
        #    then multiply them again by step
        # For a given column in cols (eg. x), assign it to the rounded_col that's at the same place in the list.
        #    Because the first item in cols is "x" and the first item in rounded_cols is "rounded_x", the output of this operation on "x" is saved to "rounded_x"
        #    This also has the effect of adding 3 more columns to the df--we now have cols called:
        #           ["x", "y", "z", "rounded_x", "rounded_y", "rounded_z"]
        df[rounded_cols] = df[cols].div(step).round().mul(step) 
        
        # This one little line is really complicated!
        # First, select the following columns:
        #    Select the columns from *within* rounded_cols which are specified by the axes list.
        #       So, if the axes list is ["x", "z"], select ["rounded_x", "rounded_z"]
        #    That is this code phrase: [rounded_cols[n] for n in axes]
        # Next, "groupby" the rounded columns. That is:
        #     Look at the columns selected in the previous step. In this example, we selected ["rounded_x", "rounded_z"]
        #     Now, if within those two columns, there are multiple rows with the same values, put all those rows into the same "group"
        #     For our example, if at any point in the data, there's "row 42" with a given rounded_x and rounded_z, and "row 48" also has that same rounded_x and rounded_z, we're going to group "row 42" and "row 48", no matter what else is in "row 42" or "row 48"
        # Now that those rows have all been put in a group, go through each group:
        #     In each group, average all the xs, all the ys, all the zs, and all the rounded_xs, rounded_ys, and rounded_zs too. Average everything until what used to be a group is now only one row.
        #     The new row has one value for x, one value for y, one value for z, and one value for each of the rounded ones too
        # But actually, we don't care about the rounded ones anymore. We used them to split the dataframe into little boxes, but now that we've averaged all the point inside each box, we're done with them
        #     So now, out of all that dataframe, we only select [cols]--that is, we only select the x, y, and z columns
        #     That's what we return. 
        return df.groupby([rounded_cols[n] for n in axes]).mean()[cols]





    # Average across all dimensions

    # Flatten the z axis
    df = import_dataframe(import_path)
    averaged_df = get_avg(df, 0.03, ["x", "y"])
    # So now, over here, we call averaging across columns "x" and "y". Here's what the algorithm does:
    #    The algorithm divides the whole cloud into cubes with rounded_x, rounded_y, and rounded_z. The size of those cubes is determined by "step"--in this case, 0.3
    #    Now, the algorithm looks at the params and sees we picked "x" and "y". So, all the points which have similar xs and similar ys (as determined by the rounding algorithm) all get grouped together
    #    All the points in that little group of points with a similar x and a similar y get averaged accross all dimensions. One point is spit out--it has their average x, their average y, and their average z
    #    Their average x and average y were already really close, because, if you remember, we picked points for this group which were close to each other in the x and y dimensions
    #    But their zs were likely not very close at all, because we didn't select for that. So now, all the zs that were in that little column we selected have been replaced by their average z
    #    To repurpose this for 3D voxel averaging, simply add a "z" parameter to the list there. 

    print("Function Called.")
    np.savetxt(export_path, averaged_df, delimiter=' ') # export the df in that space-delimited csv format again
    print("Program has finished running.")


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


## Peer Review

This algorithm should be peer reviewed by two team members with experience in data science and shown and explained to Dr. Master before it goes into production use. 

## RTFMs

The following concepts are relevant to this work:

Python, .ply, vectors, numpy, pandas, mathematical optimization, cartesian coordinate systems, averaging, dig site geometry, JSON, CLI, Ubuntu 24, Ubuntu 20, CloudCompare, data analysis standards

The dev should review any concepts with which they are not familiar. 


## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-05-25 7:25 PM Antalya Time
Revised 2026-05-26 1:50 PM Antalya Time by A. Baker