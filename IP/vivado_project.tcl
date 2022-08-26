# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl
create_project -force project_X project_X -part [DEVICE_TYPE] 
set_property board_part [BOARD_TYPE] [current_project]
add_files -norecurse ../rtl/GPIO_LED_MOD.v

proc build_BD  {} {
    source ../IP/user_role_BD.tcl
    source ../IP/Top_BD.tcl
    current_bd_design [get_bd_designs VCK190_top]
    set_property -dict [list CONFIG.ENABLE_DFX {true}] [get_bd_cells user_role_inst_0]
    set_property -dict [list CONFIG.LOCK_PROPAGATE {true}] [get_bd_cells user_role_inst_0]
    set_property APERTURES {{{0x201_0000_0000 128K}}} [get_bd_intf_pins /user_role_inst_0/CPM2PL_S_AXI_INI]
    set_property APERTURES {{{0x201_8000_0000 128K}}} [get_bd_intf_pins /user_role_inst_0/PS2PL_S_AXI_INI]
    set_property APERTURES {{{0x0 2G} {0x8_0000_0000 8G}}} [get_bd_intf_pins /user_role_inst_0/PL2DDR_M_AXI_INI]
    save_bd_design
    validate_bd_design
    update_compile_order -fileset sources_1
    generate_target all [get_files  ../IP/VCK190_top/VCK190_top.bd]
    create_ip_run [get_files -of_objects [get_fileset sources_1] ../IP/VCK190_top/VCK190_top.bd]
    launch_runs [get_runs VCK190_top*_synth*] -jobs 4
    wait_on_run [get_runs VCK190_top*_synth*]
    make_wrapper -files [get_files VCK190_top.bd] -top
    update_compile_order -fileset sources_1

}



proc customize_BD {} {

    add_files -norecurse {
        ../rtl/GPIO_LED_MOD.v
        ../IP/VCK190_top/VCK190_top.bd
        ../IP/user_role/user_role.bd
    }

}
