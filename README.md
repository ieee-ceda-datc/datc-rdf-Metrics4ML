# datc-rdf-Metrics4ML 
The Metrics4ML repository consists of collected metrics from example large-scale "Designs of Experiments" (DOEs) runs, along with config files and scripts to enable reproduction of experimental metrics data, using the open-source RTL-to-GDS flow of the [OpenROAD tool](https://github.com/The-OpenROAD-Project).  
In this repository, you will also find a description of the OpenROAD metrics **[naming convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)** and example metrics json files that are collected from tool runs. 

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
JSON format of standardized **metrics** collection in OpenROAD flow encompasses both Design metrics (#buffers, total WL, etc.) and Run metrics (cpu time, peak memory usage, etc.). Each run is delimited by braces (**{,}**) in the json dictionary.

For a detailed description of **metrics**, please see the following section: [Metrics Naming Convention](https://github.com/ieee-ceda-datc/datc-rdf-Metrics4ML#metrics-naming-convention)

### README.md
Describe the detailed configuration for each experiment.

## Metrics Naming Convention
Metrics naming has been organized based on OpenROAD version, design stage, metric category, metric name and modifiers to have a standardized mechanism of metrics reporting.
Below figure shows an example of metrics naming convention in the current OpenROAD, based on universes of **flow stage** names, **nouns** at run-level and tool metric-level, and **modifiers**.

![metrics](https://user-images.githubusercontent.com/61943381/110588518-fc366e80-8129-11eb-84a4-392614912865.png)

A sample of the logger output and extraction to metrics dashboard from the .json (or .html) is shown in the figure below.
![metrics2](https://user-images.githubusercontent.com/61943381/110588546-03f61300-812a-11eb-8270-247ef733fbc4.png)

In this way, we are currently collecting a total of 60 metrics, and we plan to continue adding metrics as needed to support ML and flow optimization.

## FAQs





  


