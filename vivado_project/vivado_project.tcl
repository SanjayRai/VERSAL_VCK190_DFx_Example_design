# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl
create_project -force project_X project_X -part [DEVICE_TYPE] 
set_property board_part [BOARD_TYPE] [current_project]


proc build_design { } {
    add_files -norecurse {
        ../IP/VCK190_top/VCK190_top.bd
        ../IP/user_role/user_role.bd
    }
    add_files -norecurse ../IP/VCK190_top/hdl/VCK190_top_wrapper.v
    add_files -fileset constrs_1 -norecurse ../xdc/VCK190_top.xdc
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

build_design
