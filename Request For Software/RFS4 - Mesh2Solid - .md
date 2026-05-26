# Request for Software: Mesh To Solid Algorithm

## What

- A program to convert two meshes into a Blender-compatible solid

    - Must be more accurate than Blender's built-in tool for this purpose

    - Goal is to design an algorithm that doesn't produce Blender's weird spikes using edge-detection and similar




## When

- Must be finished... sometime



## How

- Write this in Python. 

    - It's almost better for it not to exist than for the majority of it to be written in Bash.

    - Use C, C++, os.system() etc if you absolutely must

    - Stick to standard or very very well-known and widely-supported libraries if possible

- Must be CLI initially (no graphical interface until everything is working!)

- Must be executable (the tool you want is `chmod +x`)

- Will require deep understanding of mesh and solid format (they're all .stl s) at an encoding level

-  Extra Requirements: It's a direct data-analysis algorithm. Therefore: 

    - No AI/LLMs on this one.

    - everything must be human-written and human-understood

    - Everything must be documented for a scientist to read it

    - Ideally, there should be a mathematical description of the algorithm implemented in an ALGORITHM.md file




## Compatibility

This must interface with:

- Humans (see "Interface", below)

- An automated startup script, cron job, .profile command, or similar

- CloudCompare and Blender

    - Must be able to read .stl files from CloudCompare and export .stl files that can be read in Blender or imported back into CloudCompare

    - This means that if CloudCompare or Blender have any quirks, it's your job to make sure that your output is compatible with what they expect

This code must run on:

- Ubuntu 24.04

It would be nice if this code also ran on:

- Ubuntu 20



## Interface

Up to you, but finish a CLI before you try a GUI

## Architecture Notes

- When you design your system, make sure all the system's weights are variables at the top of the file (or in a YAML, JSON, or similar), and make them able to be overridden from the CLI. 

- If you can manage to use only standard-library Python, your system will be 10,000x more flexible, because it can run on any Linux system using system Python.
As soon as you install a non-standard package, you need to put your Python script in a virtual environment in order to run it. 



 ## Detailed Specification

The script must accept 2 .stl files which represent 3D surfaces. They will probably initialize on top of each other in vertical space, but you'll
need to check that with some actual data from CloudCompare--I can't guarantee at this moment that it will be that way, but I'm pretty sure it always
will be. 

The upper surface represents the previous day's digging. The lower surface represents the surface right now. The difference between them is the dirt
which has been removed since then. We want to obtain this volume, and we want that volume to be as accurate to life as possible. Be aware that LiDAR 
operating technicians, when they trim out a segment of pointcloud, try very hard *not* to include portions of the "wall" of the dug-out hole, because 
this has historically broken the volume-conversion algorithms. As engineer, you can change the operator proceedure how you please. You should be aware 
that all data pre-2026 (the time of this writing) used the former system, but you run the tests--if your algorithm ends up more accurate if we include 
sections of the wall, that can happen. 

You, as architect of this system, have an advantage over the Blender developers. Unlike them, you know that all the meshes that you're turning into solids
represent the top and bottom of a hole. You can therefore "weight" the vertical axis more heavily when drawing your lines, and you can also use edge-detection. 

Here's what your algorithm needs to do:

1. Find all the edges. You need to identify the sharp edges of the mesh .stls which are left by the LiDAR operator's cutting tool. 

2. Creating faces connecting the edges in the top solid to the edges in the bottom solid. These faces will be outlined by lines. 

    - Note that the solid must be air-tight! It cannot have any open faces! If you do, we can't find the volume. 

Here is a rough ASCII-art image of two meshes, as viewed from the side. 

_________________________________________________________________________
    _-_---______-____--____


    --_____n^n___--_______--
_________________________________________________________________________

Blender weights proximity more than edge-connection, so when it sees a spike in the middle of a mesh like that `n^n`, it will draw "lines"
up from there to connect to the middle of the top mesh. Then, when it fills in the lines with faces, the solid doesnt "close"--that is,
the solid has a bunch of surfaces on its inside, which it shouldn't. Any surfaces in the interior of the solid are gonna mess up our
calculation of its volume. You, on the other hand, *know this represents a hole*. Your algorithm should only connect points on the edges--
it should never connect any other two points. 

This is what Blender does:

_________________________________________________________________________
    _-_---______-____--____
            |

    --_____n^n___--_______--
_________________________________________________________________________

This is what your algorithm should do, since you know about the edges and the basic geometry of a hole:

_________________________________________________________________________
    -_---______-____--____
    |                     |  

    --_____n^n___--_______--
_________________________________________________________________________



Another thing that Blender will do is weight *absolute, 3D proximity* really heavily. Blender doens't know that the hole was dug down--its algorithm
would be equally happy if you rotated all these meshes 90 degrees and drew the lines sideways. This can cause suboptimal outcomes for us, though. 

_________________________________________________________________________
    ---v v----------_____
        v 
    --_____n^n___--_______--
_________________________________________________________________________

You see, in the situation above, Blender's 3D-weighted algorithm would draw a line between the three `v`s and the `n^n`, like this:

_________________________________________________________________________
    ---v v----------_____
        v___ 
    --_____n^n___--_______--
_________________________________________________________________________

Blender does this because those two points are physically really close together. You, however, know better! There is no wall of any hole in existence that
is oriented like that! 

Because our algorithm is only optimized for this specific use case--vertical holes--your algorithm should lean towards drawing vertical lines. That is, you can weight proximity along the Z axis more heavily than proximity along the X or Y axes. You *know* that the archaeologist dug down--so you can tell the script to 
prefer to draw lines closer to the vertical, like this: 

_________________________________________________________________________
        ---v v---_------_____
       |    v   /    |        \
        --__|__n^n___--_______--
_________________________________________________________________________

I wouldn't make this vertical line thing an absolute--there will certainly be times when a slanted line is the best representation of the dig site wall you're
simulating--but a bias towards the vertical could be really useful.

You should also be aware that unfortunately, unlike these gorgeous ASCII-art images based on `-`s and `_`s, the mesh will not necessarily be horizontal. Our
site is on a hillside, and if the archaeologist finds something interesting, they may dig more at one end than another, thus creating a sloped dig-bottom. For
this reason, a purely vertical bias vector is unfortunately not perfect. One future optimization (to be implemented after you have the z-axis bias working) would be to construct two planes, representing the average slope of each mesh. Then, find the vector that is most normal to both planes (minimize the dot products between the plane's perpendicular characteristic vectors and the bias vector. That's a 5-variable optimization algorithm that a mathematician will enjoy; find an applied math major who's taken Differential Equations and Calculus 3) and use that vector as your bias vector. 

Bear this optimization in mind when developing your z-axis bias--I strongly recommend developing a system based on bias *vectors*--NOT assumed axes--from the start,
where your initial vector just happens to be [0, 0, 1], scaled by however much. This will make applying this optimization later a lot easier. 

## Peer Review

This algorithm should be peer reviewed by two team members with experience in data science and shown and explained to Dr. Master before it goes into production use. 

## Signed

This Request for Software was put out by A. Baker, software architect. Email him with any questions.

Drafted 2026-05-25 5:50 PM Antalya Time

Revised 2026-05-25 6:12 PM Antalya Time by A. Baker