# Metrics4ML

The Metrics4ML repository provides collected metrics data from large-scale "Designs of Experiments" (DOEs) runs.
It also provides config files and scripts to enable reproduction of the experiments and their metrics data, using the open-source RTL-to-GDS flow of the [OpenROAD tool](https://github.com/The-OpenROAD-Project).

In this repository, you will also find an overview of METRICS2.1, an open-source format for collecting design and tool metrics for an RTL-to-GDS flow.
The naming convention for METRICS2.1 and a sample of the metrics file is shown [here](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention).


## Repository Structure

The repository contains the `experiments` folder at the top. Inside the experiments directory are sub directories containing the results from  specific experiments and has the following naming convention:

```
{technology node}__{design}__{the name of experiment}
```

The contents of each `experiment` sub-directory are:

- `configs` directory that contains the tar of all the config files
- `metrics` directory that contain the tar of all the collected metrics for all runs in the METRICS2.1 format

The configs directory contains the design config files used for each run.
The design config files for each run consist of the following files:

- `config-DoE-{variant name}.mk`
- `fastroute-DoE-{variant name}.tcl` (if required)
- `constraint-DoE-{variant name}.sdc` (if required)

To reproduce each run, the user should set `config-DoE-{variant name}.mk` as a `DESIGN_CONFIG` variable for [Makefile](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/Makefile) in OpenROAD tool.
The above three files for each run must be located in the `{OpenROAD}/flow/designs/{platform}/{design}/ directory`.

The metrics are collected into metrics directory. For each run, the metrics are collected separately as a JSON file.
The metrics JSON file name will be the following naming convention:
- metrics-DoE-{variant name}.json

For a detailed description of **metrics**, please see the following section: [Metrics Naming Convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)


## Metrics Naming Convention

METRICS2.1 is organized as a hierarchical JSON object as shown in the figure below.
The top level of the JSON object is the "stage" (or "snapshot").
A stage is pre-defined flow stage of the design flow and the current stages for METRICS2.1 are `run`, `init`, `synth`, `floorplan`, `globalplace`, `placeopt`, `detailedplace`, `cts`, `globalroute`, `detailedroute` and `finish`.
A snapshot can be any user defined stage or sub-stage with a unique name to capture the metrics at any point during the flow.
For example, if a user is experimenting with two different optimization recipes, they can create two separate snapshots to capture the metrics for each recipe.

![alt text](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/images/Metrics2.1_org_v2.png?raw=true)

Inside each stage are the individual metrics.
Metrics are further organized as (1) category, (2) name, (3) optional name modifier, and (4) optional classification modifiers, which are separated by a user specified delimiter string.
METRICS2.1 supports all metrics to be present at any of the stages, but certain metrics only make sense for certain stages.
For example, it only makes sense to specify the route metrics after placement. 
It is the user's responsibility to configure which metrics are extracted at which stage, based on the application. 
The user-specified delimiter string can also be used between the stage name and the metrics category to flatten the metrics for the entire design flow. 
The metric categories are currently predefined in METRICS2.1 and new categories can be added into the specifications based on future needs and user inputs.

The current metric categories are listed below.

* `flow`:  Flow related metrics.
* `design`: Metrics related to the design data including the physical PPA metrics.
* `timing`: Timing metrics.
* `clock`: Primary and derived clocks and their related metrics.
* `route`: Global and detailed router related metrics.
* `power`: Power metrics.

The metrics names are also predefined in METRICS2.1 and new names will be added in future revisions based on user inputs.
A metric name can have an optional predefined name modifier to uniquely define the metric and its units.
For example, in the design category, we have a metric name instance and a name modifier count to specify the instance count and the units would be an integer.
Similarly, in the timing category we have a metric name setup and a name modifier wns, to specify the setup timing with the worst negative slack in the design.
Many metric names will not require a name modifier, such as the metric name switching in the power category to specify the switching power consumption for the design.

METRICS2.1 also supports classification modifiers to provide more specific information about the metric.
Classification modifiers are optional and can either be type classification modifiers or structure classification modifiers.
Type classification modifiers further subdivide the metric into specific sub-types to show a distribution of the metric.
An example would be to show the breakdown of the number of instances in the design into stdcells and macros and further break down the number of stdcells into sequential or combinational.
Structure classification modifiers,  on the other hand, provide information about a specific view of the design. An example would be to provide the information for a specific analysis_view or a specific clock domain for a timing
metrics

Some sample metrics are shown below.

* `design__instance__stdcell__count`:  The the number of std cell instances in the design at that specific stage.
* `timing__setup__wns`: The worst negative slack in the design.
* `timing__setup__wns__clock:<clock_name>:path_group:<path_group_name>`:  The worst negative slack in the design for a specific clock and a specific path group.
* `route__wirelength__estimated`:  The estimated wirelength at that specific stage.
* `power__switching__total`: The total switching power consumption.

The METRICS2.1 format is shown in [METRICS2.1 format](https://docs.google.com/spreadsheets/d/e/2PACX-1vQ1d21tUGgi0W_kE-RiDww1OPUmjsLbabulHcUq7mXdOAQcWFmoX34N8uVcMHkhCjUrm04Wj_bgBC-Z/pubhtml) and a sample metrics file generated form the OpenROAD flow for the open-source core `ibex` on the open-source platform sky130-hd is show in [metrics_sample.json](./metrics_sample.json).
The sample JSON shows the metrics as a JSON record with individual metrics for each stage of the design. Also, even though only a subset of metrics are shown in each stage, the format allows for any metric to be shown at any stage.


## FAQs

1. Where can I find the version name of the tool to reproduce the experiments?
    - For the version and run date and git commit used in each experiment, please refer to  stage "run" and the metrics "flow__generate__date", "flow__openroad__version" and "flow__openroad__commit" in the JSON file

2. Does OpenROAD tool guarantees the exact same results with the same configuration and input files?
    - We believe that the current OpenROAD version does not have any "non-deterministic" behavior. With the same release version and same configuration and input files, we should see identical results.  However, since the underlying engines are constantly evolving, the metrics can and will change across new releases. The golden results for latest OpenROAD release is also uploaded to github


## References

- S. Fenstermaker, D. George, A. B. Kahng, S. Mantik and B. Thielges, "METRICS: A System Architecture for Design Process Optimization," Proc. ACM/IEEE Design Automation Conference, June 2000, pp. 705-710.
- A. B. Kahng and S. Mantik, "A System for Automatic Recording and Prediction of Design Quality Metrics," Proc. International Symposium on Quality in Electronic Design, March 2001, pp. 81-86.
MARCO GSRC Metrics website: https://vlsicad.ucsd.edu/GSRC/metrics/
- S. Hashemi , C.-T. Ho , A. B. Kahng , H.-Y. Liu , and S. Reda,   "METRICS 2.0: A  machine learning based optimization system for IC Design", Workshop on Open Source EDA Technology, November, 2018.
- J. Jung, A. B. Kahng, S. Kim and R. Varadarajan, "METRICS2.1 and Flow Tuning in the IEEE CEDA Robust Design Flow and OpenROAD," [(.pdf)](https://vlsicad.ucsd.edu/Publications/Conferences/388/c388.pdf), [(.pptx)](https://vlsicad.ucsd.edu/Publications/Conferences/388/c388.pptx), [(.mp4)](https://vlsicad.ucsd.edu/Publications/Conferences/388/c388.mp4), Proc. ACM/IEEE International Conference on Computer-Aided Design, 2021.


## Acknowledgments

METRICS2.1 has its roots in the original METRICS1.0 (DAC-2000 and ISQED-2001 papers; Dr. Stefanus Mantik's Ph.D. thesis; and the MARCO Gigascale Silicon Research Center's "Calibrating Achievable Design" thrust).
Updates to a METRICS2.0 metrics dictionary were made by the UCSD CSE 249B seminar class in Fall 2018. We thank Roger Carpenter, Colin Holehouse, Siddhartha Nath, Tuck-Boon Chan, Jiajia Li, Mohamed Shalan and the Efabless team for their inputs toward defining a more complete and stable METRICS2.1 scope and naming.
Improvements to metrics naming, reporting and messaging, and extraction in The OpenROAD Project have been contributed by Abdelrahman Hosny, Vitor Bandeira, Matt Liberty, Mehdi Saligane, Wenbo Duan, Ravi Varadarajan, Seungwon Kim, Indira Iyer, and numerous tool developers.

