# Idea: Tool to Inspect Bag and Mcap Files based on rosbags

## What

There's this CLI bag conversion utility that generates this awesome metadata file as a byproduct. It is so much quicker and easier to use than Foxglove that
I recommend writing a CLI util that literally just gets that metadata file for a given bag. 

## How

To convert "my_file.bag", I would run: `rosbags-convert my_file.bag`

It then creates a directory called `my_file/`, in which are contained the files `my_file.db3` and `metadata.yaml`

I propose a utility (to be aliased appropiately in the `~/.bash_aliases` file) which, when the user runs the command `inspect_bag my_file.bag`, `inspect_bag my_file.mcap`, or `inspect_bag my_file.db3`, runs `rosbags-convert` on the file, extracts the `metadata.yaml` file, renames it to `my_file_metadata.yaml`, and deletes the rest of the files that rosbags created. 

Optionally, it might also be a good idea to just cat that yaml file to terminal automatically after generating it, since that's probably what most people will do anyways, and it's not such a long YAML file that that would cause any problems.


## Edits

This idea was drafted by A. Baker on 2026-07-07

## Approval

This idea was approved by _____ [ nobody yet :( ] on _____. They wrote the RFC that gives detailed specifications for how to implement this idea. That file is located at _____.


