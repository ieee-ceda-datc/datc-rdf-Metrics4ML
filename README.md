# datc-rdf-Metrics4ML 
The Metrics4ML repository consists of collected metrics from example large-scale "Designs of Experiments" (DOEs) runs, along with config files and scripts to enable reproduction of experiments and their metrics data, using the open-source RTL-to-GDS flow of the [OpenROAD tool](https://github.com/The-OpenROAD-Project).  

In this repository, you will also find an overview of METRICS2.1, an open-source format for collecting design and tool metrics for an RTL-to-GDS flow. OpenROAD uses METRICS2.1 to report metrics data which is used in the continuous integration (CI) process of OpenROAD to validate Pull Requests into the project. The naming convention for METRICS2.1 and a sample of the metrics file is shown  **[here](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)**

## Contents
* [Repository Structure](#repository-structure)
* [Metrics Naming Convention](#metrics-naming-convention)
* [FAQs](#faqs)

## Repository Structure
The repository contains the **'experiments'** folder in the top. Each sub directory contains the results from a specific
experiment and has the following naming convention:
```
{technology node}__{design}__{the name of experiment}
```
The contents of each "experiment" sub directory are:
- all_config_files.tgz
- metrics (.json) files
- README.md

### all_config_files.tgz
This configs directory contains the design config files used for each run.
The design config files for each run consist of the following files:
- config-DoE-{variant name}.mk
- fastroute-DoE-{variant name}.tcl (if required)
- constraint-DoE-{variant name}.sdc (if required)

To reproduce the each run, user should set 'config-DoE-{variant name}.mk' as an 'DESIGN_CONFIG' variable for [Makefile](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/Makefile) in OpenROAD tool.
The above three files for each run must be located in the {OpenROAD}/flow/designs/{platform}/{design}/ directory.
This contains a "data" directory that is further broken down to the individual design run directories that contain all the

## metrics (.json) files 
The metrics are collected into metrics/ directory. For each run, the metrics are collected separately as a json file.
The metrics json file name will be the following naming convention:
- metrics-DoE-{variant name}.json

For a detailed description of **metrics**, please see the following section: [Metrics Naming Convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)

### README.md
Describe the detailed configuration for each experiment.

## Metrics Naming Convention

METRICS2.1 is a proposed open-source format for collecting and storing metrics for an RTL-to_GDS flow.
The open-source tool OpenROAD uses METRICS2.1 for reporting design and tool metrics. Metrics serve two valuable functions. 
They help in the continuous integration process by validating the QoR of latest check-ins and Pull Requests against a known "golden" metrics and to collect and store the metrics persistently across multiple design runs with different parameter settings.
The first is essential, as it helps to monitor the QoR of the various engines and flows against the variety of code changes. 
The second is integral in generating large amounts of data based on various input parameter settings.
This allows users to build machine learning models to hypertune the parameters and also predict the sweet spot of parameter settings for new designs and platforms.

METRICS2.1 is organized as a hierarchical JSON object. The top level of the JSON object is the "stage" or "snapshot". A
stage is pre-defined flow stage of the design flow and the current stages for METRICS2.1 are "run", "init", "synth",
"floorplan", "globalplace", "placeopt", "detailedplace", "cts", "globalroute", "detailedroute" and "finish". A snapshot
can be any user defined stage or sub-stage with a unique name to capture the metrics at any point during the flow. For
example, if a user is experimenting with two different optimization recipes, they can create two separate snapshots to
capture the metrics for each recipe.

Inside each stage or snapshot are the individual metrics. Metrics are further organized as "metric category", "metric
name" and one or more "metric modifiers" separated by a user specified delimiter string.
METERICS2.1 supports all metrics to be present at any of the stages or snapshot, but certain metrics are only
meaningful in certain stages. The current metric categories are
"flow"  to represent all the flow related metrics, "design" to represent all the metrics relating to the design data
including the physical PPA metrics, "timing" to represent all the timing PPA metrics, "clocks" to represent all the
primary and derived clocks and their values and "power" to represent all the power PPA metrics. 
For each metrics category there are a set of predefined metric names that are currently supported. 
The metric categories and metric names are currently predefined in METRICS2.1 and new categories can be added into the specification in future revisions based
on user input. 

The "metric modifier" allows for modification of a specific metric to specify additional information about the metric.
By definition, the first modifier modifies the base metric name and subsequent modifiers, modifies the previous modifier
to further sub-classify the metric.

Some sample metrics are:
- ***design__instance__stdcell__count***  represents the the number of std cell instances in the design at that specific stage.
- ***timing__setup__wns***  represents the worst negative slack in the design.
- ***timing__setup__wns__clock:<clock_name>:path_group:<path_group_name>***  represents the worst negative slack in the design
  for a specific clock and a specific path group.
- ***route__wirelength__estimated***  represents the estimated wirelength at that specific stage.
- ***power__switching__total***  represents the total switching power consumption.

The METRICS2.1 format is shown in [METRICS2.1 format](https://docs.google.com/spreadsheets/d/e/2PACX-1vQ1d21tUGgi0W_kE-RiDww1OPUmjsLbabulHcUq7mXdOAQcWFmoX34N8uVcMHkhCjUrm04Wj_bgBC-Z/pubhtml) and a sample metrics file generated form the OpenROAD flow for the open-source core "ibex" on the open-source platform sky130-hd is show in [sample_metrics.json](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/metrics_sample.json). The sample json shows the metrics as a json record with individual metrics for each stage of the design. Also, even though only a subset of metrics are shown in each stage, the format allows for any metric to be shown at any stage.

### References
- S. Fenstermaker, D. George, A. B. Kahng, S. Mantik and B. Thielges, "METRICS: A System Architecture for Design Process Optimization" Proc. ACM/IEEE Design Automation Conf., June 2000, pp. 705-710. pdf
- A. B. Kahng and S. Mantik, "A System for Automatic Recording and Prediction of Design Quality Metrics", Proc. International Symposium on Quality in Electronic Design, March 2001, pp. 81-86 pdf
MARCO GSRC Metrics website: https://vlsicad.ucsd.edu/GSRC/metrics/
- S. Hashemi , C.-T. Ho , A. B. Kahng , H.-Y. Liu , and S. Reda,   �METRICS 2.0: A  machine learning based optimization system for IC Design�, WOSET 2018   pdf
- ICCAD-2021 Metrics4ML paper  (authors/title until available in November)


### Acknowledgments

METRICS2.1 has its roots in the original METRICS1.0 (DAC-2000 and ISQED-2001 papers; Dr. Stefanus Mantik's Ph.D. thesis;
and the MARCO Gigascale Silicon Research Center's "Calibrating Achievable Design" thrust). 
Updates to a METRICS2.0 metrics dictionary were made by the UCSD CSE 249B seminar class in Fall 2018. We thank Roger Carpenter, Colin Holehouse, Siddhartha Nath, Tuck-Boon Chan, Jiajia Li, Mohamed Shalan and the Efabless team for their inputs toward defining a more complete and stable METRICS2.1 scope and naming.  
Improvements to metrics naming, reporting and messaging, and extraction in The OpenROAD Project have been contributed by Abdelrahman Hosny, Vitor Bandeira, Matt Liberty, Mehdi Saligane, Wenbo Duan, Seungwon Kim, Indira Iyer, and numerous tool developers.

## FAQs
1. Q. Where can I find the version name of the tool to reproduce the experiments?  
A. For the version and run date and git commit used in each experiment, please refer to  stage "run" and the metrics "flow__generate__date", "flow__openroad__version" and "flow__openroad__commit" in the json file

2. Q. Does OpenROAD tool guarantees the exact same results with the same configuration and input files?  
A. We believe that the current OpenROAD version does not have any "non-deterministic" behavior. With the same release version and same configuration and input files, we should see identical results.  However, since the underlying engines are constantly evolving, the metrics can and will change across new releases. The golden results for latest OpenROAD release is also uploaded to github 

  


