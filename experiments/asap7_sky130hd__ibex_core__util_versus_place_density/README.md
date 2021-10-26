# core_util__
## Experiment Desciption
This experiment studies the relationship between the core utilization of floorplan and the placement density parameter of the RePlAce global placer
Platform: asap7, sky130hd
Designs: ibex_core
Core Utilization: 10% to 60%, step 1%.
Place Density delta (over Core Utilization): 0 to 90% in steps of 2%
Total #runs = 2295 per platform for a total of 4580 

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
[A sample Jupyter Notebook](https://nbviewer.jupyter.org/github/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/experiments/multiple_platforms__multiple_designs__util_versus_layer_adjust/METRICS2.1-exp3.ipynb) to visualize the data and build simple models to predict on unseen data is shown.

[The output from running the Jupyter notebook](https://nbviewer.jupyter.org/github/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/experiments/multiple_platforms__multiple_designs__util_versus_layer_adjust/METRICS2.1-exp3.html) is also shown without the Python code.

