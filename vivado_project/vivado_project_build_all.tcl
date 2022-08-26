# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl
create_project -force project_X project_X -part [DEVICE_TYPE] 
set_property board_part [BOARD_TYPE] [current_project]

proc build_BD  {} {
    
    add_files -norecurse ../rtl/GPIO_LED_MOD.v
    source ../IP/user_role_BD.tcl
    source ../IP/Top_BD.tcl
    current_bd_design [get_bd_designs VCK190_top]
    set_property -dict [list CONFIG.ENABLE_DFX {true}] [get_bd_cells user_role_inst_0]
    set_property -dict [list CONFIG.LOCK_PROPAGATE {true}] [get_bd_cells user_role_inst_0]
    set_property APERTURES {{{0x201_0000_0000 128K}}} [get_bd_intf_pins /user_role_inst_0/CPM2PL_S_AXI_INI]
    set_property APERTURES {{{0x201_8000_0000 128K}}} [get_bd_intf_pins /user_role_inst_0/PS2PL_S_AXI_INI]
    set_property APERTURES {{{0x202_0000_0000 2M}}} [get_bd_intf_pins /user_role_inst_0/DBG_HUB_RP]
    set_property APERTURES {{{0x0 2G} {0x8_0000_0000 8G}}} [get_bd_intf_pins /user_role_inst_0/PL2DDR_M_AXI_INI]
    save_bd_design
    validate_bd_design
    update_compile_order -fileset sources_1
    generate_target all [get_files  ../IP/VCK190_top/VCK190_top.bd]
    create_ip_run [get_files -of_objects [get_fileset sources_1] ../IP/VCK190_top/VCK190_top.bd]
    launch_runs [get_runs VCK190_top*_synth*] -jobs 4
    wait_on_run [get_runs VCK190_top*_synth*]
    make_wrapper -files [get_files VCK190_top.bd] -top
    add_files -norecurse ../IP/VCK190_top/hdl/VCK190_top_wrapper.v
    add_files -fileset constrs_1 -norecurse ../xdc/VCK190_top.xdc
    update_compile_order -fileset sources_1
}

proc build_design { } {
    update_compile_order -fileset sources_1
    create_pr_configuration -name config_1 -partitions [list VCK190_top_i/user_role_inst_0:user_role_inst_0 ]
    create_pr_configuration -name config_2 -partitions { }  -greyboxes [list VCK190_top_i/user_role_inst_0 ]
    set_property PR_CONFIGURATION config_1 [get_runs impl_1]
    create_run child_0_impl_1 -parent_run impl_1 -flow {Vivado Implementation 2022} -pr_config config_2
    launch_runs impl_1 child_0_impl_1 -to_step write_bitstream -jobs 8
    wait_on_run child_0_impl_1
    open_run impl_1
    report_clock_interaction -delay_type min_max -significant_digits 3 -name timing_1
    write_hw_platform -fixed -include_bit -force -file ./VCK190_top_wrapper.xsa
}

build_BD 
build_design

