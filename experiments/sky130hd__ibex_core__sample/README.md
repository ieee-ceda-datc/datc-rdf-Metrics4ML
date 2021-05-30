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

[A sample Jupyter
Notebook](https://nbviewer.jupyter.org/github/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/experiments/sky130hd__ibex_core__sample/metrics_21_layer_adjust.ipynb) to visualize the data and build simple models to predict on unseen data is shown 

[The output from running the Jupyter notebook](http://htmlpreview.github.io/?https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/experiments/sky130hd__ibex_core__sample/metrics_21_layer_adjust.html) is also shown
