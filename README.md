# datc-rdf-Metrics4ML 
The Metrics4ML repository consists of collected metrics from example large-scale "Designs of Experiments" (DOEs) runs, along with config files and scripts to enable reproduction of experiments and their metrics data, using the open-source RTL-to-GDS flow of the [OpenROAD tool](https://github.com/The-OpenROAD-Project).  

In this repository, you will also find an overview of Metrics 2.1, an open-source format for collecting design and tool metrics for an RTL-to-GDS flow. OpenROAD uses Metrics 2.1 to report metrics data which is used in the continuous integration (CI) process of OpenROAD to validate Pull Requests into the project. The naming convention for Metrics 2.1 and a sample of the metrics file is shown  **[here](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)**

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

Metrics 2.1 is a proposed open-source format for collecting and storing metrics for an RTL-to_GDS flow. The open-source tool OpenROAD uses Metrics 2.1 for reporting design and tool metrics. Metrics serve two valuable functions. They help in the continuous integration process by validating the QoR of latest checkins and Pull Requests against a known "golden" metrics and to collect and store the metrics persistently across multiple design runs with different parameter settings. The first is essential, as it helps to monitor the QoR of the various engines and flows against the variety of code changes. The second is integral in generating large amounts of data based on various input parameter settings.  This allows users to build machine learning models to hypertune the parameters and also predict the sweet spot of parameter settings for new designs and platforms.

Metrics 2.1 is organized as a hierarchical JSON object. The top level of the JSON object is the "stage" or "snapshot". A
stage is pre-defined flow stage of the design flow and the current stages for Metrics 2.1 are "run", "init", "synth",
"floorplan", "globalplace", "placeopt", "detailedplace", "cts", "globalroute", "detailedroute" and "finish". A snapshot
can be any user defined stage with a unique name to capture the metrics at any point during the flow.

Inside each stage or snapshot are the individual metrics. Metrics are futher organized as "metrics category", "metric
name" and one or more "metric modifiers" separated by a user specified delimeter string. The current metric categories are
"flow"  to represent all the flow related metrics, "design" to represent all the metrics relating to the design data
including the physical PPA metrics, "timing" to represent all the timing PPA metrics, "clocks" to represent all the
primary and derived clocks and their values and "power" to represent all the power PPA metrics.

Some sample metrics are:
- ***design__instance__stdcell__count***  represents the the number of std cell instances in the design at that specific stage.
- ***timing__setup__wns***  represents the worst negative slack in the design.
- ***timing__setup__wns__clock:<clock_name>:path_group:<path_group_name>***  represents the worst negative slack in the design
  for a specific clock and a specific path group.
- ***route__wirelength__estimated***  represents the estimated wirelength at that specific stage.
- ***power__switching__total***  represents the total switching power consumption.

A sample metrics file generated form the OpenROAD flow for the open-source core "ibex" on the open-source platform sky130-hd is show in [sample_metrics.json](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML/blob/main/metrics_sample.json )

## FAQs
1. Q. Where can I find the version name of the tool to reproduce the experiments?  
A. For the version and run date and git commit used in each experiment, please refer to  stage "run" and the metrics "flow__generate__date", "flow__openroad__version" and "flow__openroad__commit" in the json file

2. Q. Does OpenROAD tool guarantees the exact same results with the same configuration and input files?  
A. We believe that the current OpenROAD version does not have any "non-deterministic" behavior. With the same release version and same configuration and input files, we should see identical results.  However, since the underlying engines are constantly evolving, the metrics can and will change across new releases. The golden results for latest OpenROAD release is also uploaded to github 

  


