# CloudCompare g2o Reader Plugin

## What

A CloudCompare plugin enabling it to read .g2o files and import them as (the already existing) polyline objects. 

## Why

It's always good to contribute to the Open Source community--it's part of why we're here--and this would be a fairly simple way we could contribute to a project that has meant a lot to us over the years. 

## How

In the SLAM_testing repo, at /tools/g2o-to-poly.py, is a Python script that we have written that already does this. The core logic is there already. Someone just needs to translate it from Python to C, learn the CloudCompare extension structure, and build a version for them.

Debug VERY rigorously before you even _think_ about a pull request/wiki edit! Bad open source code to do something is significantly worse than no code at all for a project like CloudCompare, which doesn't have enough humans working on it for them to have time to catch your bugs. Test it HARD.

Also, be aware that this makes some assumptions about .g2os that only apply to those exported by our particular SLAM. Read all the specs involved very carefully first. 


## Edits

This idea was drafted by A. Baker on 2026-07-14

## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


