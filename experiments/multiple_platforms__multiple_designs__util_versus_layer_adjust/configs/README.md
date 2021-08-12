# config files 
This config directory contains the additional runscripts and design config files used for each run.
To reproduce the each run, this directory should overwrite the OpenROAD flow scripts [repo](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts).
OpenROAD flow scripts repo commit is 951fdd39f3856cb05bc1d620d23f87e1be76d316

The additional runscripts contain commands to execute each run. 
The addtional runscripts includes following files:
- runMassive_asap7.sh
- runMassive_sky130hd.sh

The design config files for each run consist of the following files:
- config-DoE-{variant name}.mk
- fastroute-DoE-{variant name}.tcl (if required)
- constraint-DoE-{variant name}.sdc (if required)


