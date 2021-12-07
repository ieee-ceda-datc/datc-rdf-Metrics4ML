# util_layer_adjust
## Experiment Description
This experiment changes the 'layer_adjust' parameters for global route and the core utilization of the floorplan to see its effect on the detailed router and the routed wirelength.
* Platform: asap7, sky130hd
* Designs: aes_cipher, ibex_core, jpeg_encoder
* Core Utilization: 10% to 60%, step 1%.
* Layer Adjust: For M1 to Mtop, sweep 0.2 to 0.6, step 0.02.
* Total #runs = 6426

This experiment was run with an OpenROAD commit that used an older specification of METRICS2.1. The metrics name changes
to the latest version is shown in [METRICS2.1_V2 changes](../../METRICS2.1_V2_changes.md).

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

