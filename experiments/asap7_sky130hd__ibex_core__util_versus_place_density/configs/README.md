# config files 
This config directory contains the additional runscripts and design config files used for each run.
To reproduce the each run, this directory should overwrite the OpenROAD flow scripts [repo](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts).
OpenROAD flow scripts repo commit is 7dc490a78486f05800553a1985f90a2b2238ddc8

The additional runscripts contain commands to execute each run. 
The addtional runscripts includes following files:
- runMassive.sh

The design config files for each run consist of the following files:
- config-DoE-{variant name}.mk
- fastroute-DoE-{variant name}.tcl (if required)
- constraint-DoE-{variant name}.sdc (if required)


