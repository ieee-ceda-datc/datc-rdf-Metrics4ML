# Sample run
In this sample run, results are not compressed by tarball to show the file structure.

## metrics (.json) files 
The metrics are collected into metrics/ directory. For each run, the metrics are collected separately as a json file.
The metrics json file name will be the following naming convention:
- metrics-DoE-{variant name}.json

## config files 
This configs directory contains the design config files used for each run.
The design config files for each run consist of the following files:
- config-DoE-{variant name}.mk
- fastroute-DoE-{variant name}.tcl (if required)
- constraint-DoE-{variant name}.sdc (if required)

To reproduce the each run, user should set 'config-DoE-{variant name}.mk' as an 'DESIGN_CONFIG' variable for [Makefile](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/Makefile) in OpenROAD tool.
The above three files for each run must be located in the {OpenROAD}/flow/designs/{platform}/{design}/ directory.

