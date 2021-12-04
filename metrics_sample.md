# Sample of METRICS2.1  metrics collected from OpenROAD

* `flow__openroad_commit`: OpenROAD commit for the run.
* `flow__scripts_commit`: OpenROAD flow scripts commit for the run.
* `flow__design`: Design name for the run.
* `flow__platform`: Technology platform for the run.
* `design__instance__count__stdcell`:  The the number of std cell instances in the design at that specific stage.
* `timing__setup__wns`: The worst negative slack in the design.
* `timing__setup__wns__clock:<clock_name>:path_group:<path_group_name>`:  The worst negative slack in the design for a specific clock and a specific path group.
* `clock__skew__worst`: Worst skew for the default clock. 
* `route__wirelength__estimated`:  The estimated wirelength at that specific stage.
* `route__drc_errors`:  Total DRC errors in the design
* `power__total`: The total power consumption the design.
* `power__switching__total`: The total switching power consumption in the design.
