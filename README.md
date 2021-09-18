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
They help in the continuous integration process by validating the QoR of latest check-ins and pull requests against a known "golden" metrics and to collect and store the metrics persistently across multiple design runs with different parameter settings.
The first is essential, as it helps to monitor the QoR of the various engines and flows against the variety of code changes.
Also, as the metrics are persistent, they enable to create trend reports of the various QoR metrics over time periods.
The second is integral in generating large amounts of data based on various input parameter settings.
This allows users to build machine learning models to hypertune the parameters and also predict the sweet spot of parameter settings for new designs and platforms.


The primary motivation of METRICS2.1 is simplicity, non-ambiguity and to define the syntax and semantics for future additions of new metrics.
A guiding precept is that (i) any desired measurement must map to a unique METRICS2.1 metric, and
(ii) every METRICS2.1 metric must map to a unique interpretation as a measurement and should be intuitively obvious to most mainstream users.
This two way mapping is crucial to avoid any future confusion.
Moreover, in a typical EDA design flow, the value of specific metric changes throughout the flow. 
For example, the number of instances in design changes as the design goes through various stages such as synthesis, placement, optimization,, CTS etc. 
Hence it is important to capture the same metric at different stages in the design flow.


METRICS2.1 is organized as a hierarchical JSON object. The top level of the JSON object is the "stage" or "snapshot". A
stage is pre-defined flow stage of the design flow and the current stages for METRICS2.1 are "run", "init", "synth",
"floorplan", "globalplace", "placeopt", "detailedplace", "cts", "globalroute", "detailedroute" and "finish". A snapshot
can be any user defined stage or sub-stage with a unique name to capture the metrics at any point during the flow. For
example, if a user is experimenting with two different optimization recipes, they can create two separate snapshots to
capture the metrics for each recipe.

Inside each stage or snapshot are the individual metrics.
Metrics are further organized as metrics category,  metrics  name, an optional metrics name modifier, and optional metrics classification modifiers 
separated by a user specified delimiter string. 
METRICS2.1 supports all metrics to be present at any of the stages or snapshots, but certain metrics only make sense for certain stages. 
For example, it only makes sense to specify the route metrics post placement. It is the user's responsibility to configure which metrics are extracted at which stage, based on the application. 
The user-specified delimiter string can also be used between the stage or snapshot name and the metrics category to flatten the metrics for the entire design flow.. The metric categories are currently predefined in METRICS2.1 and new categories can be added into the specifications based on future needs and user inputs.

The current metric categories are "flow"  to represent all the flow related metrics, 
"design" to represent all the metrics relating to the design data including the physical PPA metrics, 
"timing" to represent all the timing PPA metrics, "clock" to represent all the primary and derived clocks and their values, 
"route" to represent all the global and detailed router related metrics and 
"power" to represent all the power PPA metrics.


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
- S. Hashemi , C.-T. Ho , A. B. Kahng , H.-Y. Liu , and S. Reda,   "METRICS 2.0: A  machine learning based optimization system for IC Design", WOSET 2018   pdf
- ICCAD-2021 Metrics4ML paper  (authors/title until available in November)


### Acknowledgments

METRICS2.1 has its roots in the original METRICS1.0 (DAC-2000 and ISQED-2001 papers; Dr. Stefanus Mantik's Ph.D. thesis;
and the MARCO Gigascale Silicon Research Center's "Calibrating Achievable Design" thrust). 
Updates to a METRICS2.0 metrics dictionary were made by the UCSD CSE 249B seminar class in Fall 2018. We thank Roger Carpenter, Colin Holehouse, Siddhartha Nath, Tuck-Boon Chan, Jiajia Li, Mohamed Shalan and the Efabless team for their inputs toward defining a more complete and stable METRICS2.1 scope and naming.  
Improvements to metrics naming, reporting and messaging, and extraction in The OpenROAD Project have been contributed by Abdelrahman Hosny, Vitor Bandeira, Matt Liberty, Mehdi Saligane, Wenbo Duan, Ravi Varadarajan, Seungwon Kim, Indira Iyer, and numerous tool developers.

## FAQs
1. Q. Where can I find the version name of the tool to reproduce the experiments?  
A. For the version and run date and git commit used in each experiment, please refer to  stage "run" and the metrics "flow__generate__date", "flow__openroad__version" and "flow__openroad__commit" in the json file

2. Q. Does OpenROAD tool guarantees the exact same results with the same configuration and input files?  
A. We believe that the current OpenROAD version does not have any "non-deterministic" behavior. With the same release version and same configuration and input files, we should see identical results.  However, since the underlying engines are constantly evolving, the metrics can and will change across new releases. The golden results for latest OpenROAD release is also uploaded to github 

  


