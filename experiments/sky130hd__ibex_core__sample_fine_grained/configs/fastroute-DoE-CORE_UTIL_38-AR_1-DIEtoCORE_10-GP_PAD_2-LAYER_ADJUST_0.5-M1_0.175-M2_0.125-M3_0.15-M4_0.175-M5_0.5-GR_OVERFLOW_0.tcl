set_global_routing_layer_adjustment $::env(MIN_ROUTING_LAYER)-$::env(MAX_ROUTING_LAYER) 0.5
set_global_routing_layer_adjustment met1 0.2
set_global_routing_layer_adjustment met2 0.1
set_global_routing_layer_adjustment met3 0.1
set_global_routing_layer_adjustment met4 0.2
set_global_routing_layer_adjustment met5 0.5

set_routing_layers -signal $::env(MIN_ROUTING_LAYER)-$::env(MAX_ROUTING_LAYER)

global_route -guide_file $::env(RESULTS_DIR)/route.guide \
             -overflow_iterations 100 \
	         -verbose 2
