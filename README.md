# datc-rdf-Metrics4ML 
The Metrics4ML repository consists of collected metrics from example large-scale "Designs of Experiments" (DOEs) runs, along with config files and scripts to enable reproduction of experimental metrics data, using the open-source RTL-to-GDS flow of the [OpenROAD tool](https://github.com/The-OpenROAD-Project).  
In this repository, you will also find a description of the OpenROAD metrics **[naming convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)** and example metrics JSON files that are collected from tool runs. 

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
- metrics.html
- metrics.json
- README.md

### all_config_files.tgz
This contains a "data" directory that is further broken down to the individual design run directories that contain all the
Makefile and config file settings to replicate the runs

- Makefile
  - OpenROAD Makefile to replace original [Makefile](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/Makefile).

- Technology platform config.mk file
  - Replaces the config file used by each technology platform in the OpenROAD flow.
  - Example sky130hs platform [config.mk](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/platforms/sky130hs/config.mk) file.

- design/config.mk
  - Design config file (config.mk) used by OpenROAD flow.

- design/constraint.sdc
  - Timing constraint file (constraint.sdc) for the design.

### metrics.html
HTML format of standardized **metrics** collection in OpenROAD flow encompasses both Design metrics (#buffers, total WL, etc.) and Run metrics (cpu time, peak memory usage, etc.). Each run is divided into columns.

### metrics.json
JSON format of standardized **metrics** collection in OpenROAD flow encompasses both Design metrics (#buffers, total WL, etc.) and Run metrics (cpu time, peak memory usage, etc.). Each run is delimited by braces (**{,}**) in the JSON dictionary.

For a detailed description of **metrics**, please see the following section: [Metrics Naming Convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)

### README.md
Describe the detailed configuration for each experiment.

## Metrics Naming Convention

Metrics naming has been organized based on OpenROAD version, design stage, metric category, metric name and modifiers to have a standardized mechanism of metrics reporting.

The header of the metrics file contains information pertaining to the OpenROAD release such as commit hash,
and the run date and design data information such as design name and the target platform

The current design stages are "synth", "constraints", "floorplan", "globalplace", "placeopt", "detailedplace",
"cts", "globalroute", "detailedroute" and "finish". The metric categories are "area", "timing", "power"
and "clocks".  The metric name and modifiers describe additional information about the metrics. 
For example the metrics "floorplan__area__stdcell__count" specifies the number of standard cell instances at the floorplan stage. 

A sample of the logger output and extraction to metrics dashboard from the .json (or .html) is shown in the figure below.
![metrics2](https://user-images.githubusercontent.com/61943381/110588546-03f61300-812a-11eb-8270-247ef733fbc4.png)

In this way, we are currently collecting a total of 60 metrics, and we plan to continue adding metrics as needed to support ML and flow optimization.

## FAQs
1. Q. Isn't a single JSON file for independent runs better than one "big list" of JSON objects for scalability in data collection?  
A. Metrics for individual runs are also present as json files in the run directory for each run. OpenROAD metrics collection, then collates all of the individual metrics into a single json file for the entire experiment for ease of data analytics.

2. Q. Where can I find the version name of the tool to reproduce the experiments?  
A. For the version and run date and git commit used in each experiment, please refer to "run__flow__date", "run__flow__version" and "run__flow__commit" inside the metrics.json file.

3. Q. Does OpenROAD tool guarantees the exact same results with the same configuration and input files?  
A. We believe that the current OpenROAD version does not have any "non-deterministic" behavior. With the same release version and same configuration and input files, we should see identical results.  However, since the underlying engines are constantly evolving, the metrics can and will change across new releases. The golden results for latest OpenROAD release is also uploaded to github 

  


