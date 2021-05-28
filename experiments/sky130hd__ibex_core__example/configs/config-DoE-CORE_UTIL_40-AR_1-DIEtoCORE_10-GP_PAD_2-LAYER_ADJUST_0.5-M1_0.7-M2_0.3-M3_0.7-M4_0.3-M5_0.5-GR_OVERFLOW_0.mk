include $(dir $(DESIGN_CONFIG))/config.mk

FLOW_VARIANT = CORE_UTIL_40-AR_1-DIEtoCORE_10-GP_PAD_2-LAYER_ADJUST_0.5-M1_0.7-M2_0.3-M3_0.7-M4_0.3-M5_0.5-GR_OVERFLOW_0

export CORE_UTILIZATION = 40
export PLACE_DENSITY = 0.71
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 10
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 2
export FASTROUTE_TCL = $(dir $(DESIGN_CONFIG))/fastroute-DoE-CORE_UTIL_40-AR_1-DIEtoCORE_10-GP_PAD_2-LAYER_ADJUST_0.5-M1_0.7-M2_0.3-M3_0.7-M4_0.3-M5_0.5-GR_OVERFLOW_0.tcl