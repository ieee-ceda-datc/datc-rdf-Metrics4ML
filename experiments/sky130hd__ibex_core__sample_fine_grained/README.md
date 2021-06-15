# Sample run
In this sample run, files are not compressed by tarball to show the file structure.

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

## Jupyter Notebook
[A sample Jupyter Notebook]() to visualize the data and build simple models to predict on unseen data is shown.

[The output from running the Jupyter notebook]() is also shown without the Python code.
