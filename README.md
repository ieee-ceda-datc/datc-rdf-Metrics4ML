# datc-rdf-calibrations-metrics (Metrics4ML)
The Metrics4ML repository consists of metrics and config files for reproducing the experiment from the RDL-to-GDS flow using OpenROAD tool.

## Repository Structure
The repository contains the 'experiments' folder in the top, where each experiment consists of the following naming convention
```
{technology node}_{design}_{the name of experiment}
```
Each experimental folder contains the contents from multiple runs.

In addition, each experimental folder consists of the following contents.
* all_config_files.tgz
* metrics.html
* metrics.json
* README.md

Below is a detailed description of each content.
### all_config_files.tgz
The following files for all runs used in the experiments.
* Makefile
OpenROAD Makefile to replace original [Makefile](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/Makefile).

* Technology platform config (.mk) file
Replaces the config file used by each technology platform in the OpenROAD flow..

Example) sky130hs platform [config.mk](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/master/flow/platforms/sky130hs/config.mk) file.

* design/config.mk
Design config file (config.mk) used by OpenROAD flow.

* design/constraint.sdc
Timing constraint file (constraint.sdc) for the design.

### metrics.html
HTML formal of standardized metrics collection in OpenROAD flow encompasses both Design metrics (#buffers, total WL, etc.) and Run metrics (cpu time, peak memory usage, etc.).

### metrics.json
JSON format of standardized metrics collection in OpenROAD flow encompasses both Design metrics (#buffers, total WL) and Run metrics (cpu time, peak memory usage).

### README.md
Describe the detailed configuration for each experiment.



