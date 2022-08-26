
################################################################
# This is a generated script based on design: user_role
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source user_role_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# GPIO_LED_MOD

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvc1902-vsva2197-2MP-e-S
   set_property BOARD_PART xilinx.com:vck190:part0:3.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name user_role

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ../IP

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2030 -severity "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_gid_msg -ssname BD::TCL -id 2031 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_gid_msg -ssname BD::TCL -id 2032 -severity "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2033 -severity "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2034 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2035 -severity "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_gid_msg -ssname BD::TCL -id 2036 -severity "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2037 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_gid_msg -ssname BD::TCL -id 2038 -severity "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axis_ila:1.1\
xilinx.com:ip:emb_mem_gen:1.0\
xilinx.com:ip:axi_cdma:4.1\
xilinx.com:ip:axi_dbg_hub:2.0\
xilinx.com:ip:axi_noc:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
GPIO_LED_MOD\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set CPM2PL_S_AXI_INI [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:inimm_rtl:1.0 CPM2PL_S_AXI_INI ]
  set_property -dict [ list \
   CONFIG.INI_STRATEGY {load} \
   ] $CPM2PL_S_AXI_INI

  set DBG_HUB_RP [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:inimm_rtl:1.0 DBG_HUB_RP ]
  set_property -dict [ list \
   CONFIG.INI_STRATEGY {load} \
   ] $DBG_HUB_RP

  set PL2DDR_M_AXI_INI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 PL2DDR_M_AXI_INI ]
  set_property -dict [ list \
   CONFIG.COMPUTED_STRATEGY {driver} \
   CONFIG.INI_STRATEGY {driver} \
   ] $PL2DDR_M_AXI_INI

  set PS2PL_S_AXI_INI [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:inimm_rtl:1.0 PS2PL_S_AXI_INI ]
  set_property -dict [ list \
   CONFIG.INI_STRATEGY {load} \
   ] $PS2PL_S_AXI_INI


  # Create ports
  set CPM_areset_n [ create_bd_port -dir I -type rst CPM_areset_n ]
  set CPM_clk [ create_bd_port -dir I -type clk -freq_hz 250000000 CPM_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {PL2DDR_M_AXI_INI:PS2PL_S_AXI_INI:CPM2PL_S_AXI_INI} \
 ] $CPM_clk
  set GPIO_LED_o [ create_bd_port -dir IO -from 3 -to 0 GPIO_LED_o ]
  set pl_clk333mhz [ create_bd_port -dir I -type clk -freq_hz 333333008 pl_clk333mhz ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {DBG_HUB_RP} \
 ] $pl_clk333mhz
  set pl_reset [ create_bd_port -dir I pl_reset ]

  # Create instance: CPM2PL_AXI_BRAM, and set properties
  set CPM2PL_AXI_BRAM [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 CPM2PL_AXI_BRAM ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
 ] $CPM2PL_AXI_BRAM

  # Create instance: CPM_BRAM_ILA, and set properties
  set CPM_BRAM_ILA [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_ila:1.1 CPM_BRAM_ILA ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {0} \
   CONFIG.C_INPUT_PIPE_STAGES {1} \
   CONFIG.C_MON_TYPE {Interface_Monitor} \
   CONFIG.C_SLOT_0_AXI_AR_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_R_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_AXI_W_SEL_TRIG {0} \
 ] $CPM_BRAM_ILA

  # Create instance: CPM_PS_SHARED_AXI_BRAM_bram, and set properties
  set CPM_PS_SHARED_AXI_BRAM_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 CPM_PS_SHARED_AXI_BRAM_bram ]
  set_property -dict [ list \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
 ] $CPM_PS_SHARED_AXI_BRAM_bram

  # Create instance: GPIO_LED_MOD_0, and set properties
  set block_name GPIO_LED_MOD
  set block_cell_name GPIO_LED_MOD_0
  if { [catch {set GPIO_LED_MOD_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $GPIO_LED_MOD_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: PL2DDR_CDMA, and set properties
  set PL2DDR_CDMA [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 PL2DDR_CDMA ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {64} \
   CONFIG.C_INCLUDE_SG {0} \
   CONFIG.C_M_AXI_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MAX_BURST_LEN {128} \
 ] $PL2DDR_CDMA

  # Create instance: PS2PL_AXI_BRAM, and set properties
  set PS2PL_AXI_BRAM [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 PS2PL_AXI_BRAM ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
 ] $PS2PL_AXI_BRAM

  # Create instance: PS2PL_AXI_BRAM_bram, and set properties
  set PS2PL_AXI_BRAM_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 PS2PL_AXI_BRAM_bram ]
  set_property -dict [ list \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
 ] $PS2PL_AXI_BRAM_bram

  # Create instance: PS_BRAM_ILA, and set properties
  set PS_BRAM_ILA [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_ila:1.1 PS_BRAM_ILA ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {0} \
   CONFIG.C_INPUT_PIPE_STAGES {1} \
   CONFIG.C_MON_TYPE {Interface_Monitor} \
   CONFIG.C_SLOT_0_AXI_AR_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_R_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_AXI_W_SEL_TRIG {0} \
 ] $PS_BRAM_ILA

  # Create instance: axi_dbg_hub_0, and set properties
  set axi_dbg_hub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dbg_hub:2.0 axi_dbg_hub_0 ]

  # Create instance: axi_noc_0, and set properties
  set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
  set_property -dict [ list \
   CONFIG.NUM_NSI {1} \
   CONFIG.NUM_SI {0} \
 ] $axi_noc_0

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_AXI {read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /axi_noc_0/S00_INI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk0]

  # Create instance: axi_noc_INI_CPM_PL, and set properties
  set axi_noc_INI_CPM_PL [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_INI_CPM_PL ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_NSI {1} \
   CONFIG.NUM_SI {0} \
 ] $axi_noc_INI_CPM_PL

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_AXI {read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /axi_noc_INI_CPM_PL/S00_INI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /axi_noc_INI_CPM_PL/aclk0]

  # Create instance: axi_noc_INI_PL2DDR, and set properties
  set axi_noc_INI_PL2DDR [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_INI_PL2DDR ]
  set_property -dict [ list \
   CONFIG.NUM_MI {0} \
   CONFIG.NUM_NMI {1} \
 ] $axi_noc_INI_PL2DDR

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_INI {read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /axi_noc_INI_PL2DDR/S00_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /axi_noc_INI_PL2DDR/aclk0]

  # Create instance: axi_noc_INI_PS2PL, and set properties
  set axi_noc_INI_PS2PL [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_INI_PS2PL ]
  set_property -dict [ list \
   CONFIG.NUM_NSI {1} \
   CONFIG.NUM_SI {0} \
 ] $axi_noc_INI_PS2PL

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_AXI {read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /axi_noc_INI_PS2PL/S00_INI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /axi_noc_INI_PS2PL/aclk0]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IOBUF} \
   CONFIG.C_SIZE {4} \
 ] $util_ds_buf_0

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_2

  # Create interface connections
  connect_bd_intf_net -intf_net CPM2PL_AXI_BRAM1_BRAM_PORTA [get_bd_intf_pins PS2PL_AXI_BRAM/BRAM_PORTA] [get_bd_intf_pins PS2PL_AXI_BRAM_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net CPM2PL_AXI_BRAM1_BRAM_PORTB [get_bd_intf_pins PS2PL_AXI_BRAM/BRAM_PORTB] [get_bd_intf_pins PS2PL_AXI_BRAM_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net CPM2PL_AXI_BRAM_BRAM_PORTA [get_bd_intf_pins CPM2PL_AXI_BRAM/BRAM_PORTA] [get_bd_intf_pins CPM_PS_SHARED_AXI_BRAM_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net CPM2PL_AXI_BRAM_BRAM_PORTB [get_bd_intf_pins CPM2PL_AXI_BRAM/BRAM_PORTB] [get_bd_intf_pins CPM_PS_SHARED_AXI_BRAM_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net PL2DDR_CDMA_M_AXI [get_bd_intf_pins PL2DDR_CDMA/M_AXI] [get_bd_intf_pins axi_noc_INI_PL2DDR/S00_AXI]
  connect_bd_intf_net -intf_net S00_INI_0_1 [get_bd_intf_ports CPM2PL_S_AXI_INI] [get_bd_intf_pins axi_noc_INI_CPM_PL/S00_INI]
  connect_bd_intf_net -intf_net S00_INI_0_2 [get_bd_intf_ports PS2PL_S_AXI_INI] [get_bd_intf_pins axi_noc_INI_PS2PL/S00_INI]
  connect_bd_intf_net -intf_net S00_INI_0_3 [get_bd_intf_ports DBG_HUB_RP] [get_bd_intf_pins axi_noc_0/S00_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M00_AXI1 [get_bd_intf_pins PS2PL_AXI_BRAM/S_AXI] [get_bd_intf_pins axi_noc_INI_PS2PL/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_noc_0_M00_AXI1] [get_bd_intf_pins PS_BRAM_ILA/SLOT_0_AXI] [get_bd_intf_pins axi_noc_INI_PS2PL/M00_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M00_AXI2 [get_bd_intf_pins axi_dbg_hub_0/S_AXI] [get_bd_intf_pins axi_noc_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_noc_1_M00_INI [get_bd_intf_ports PL2DDR_M_AXI_INI] [get_bd_intf_pins axi_noc_INI_PL2DDR/M00_INI]
  connect_bd_intf_net -intf_net axi_noc_INI_CPM_PL_M00_AXI [get_bd_intf_pins axi_noc_INI_CPM_PL/M00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins CPM2PL_AXI_BRAM/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets smartconnect_0_M00_AXI] [get_bd_intf_pins CPM_BRAM_ILA/SLOT_0_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins PL2DDR_CDMA/S_AXI_LITE] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net CPM_areset_n_1 [get_bd_ports CPM_areset_n] [get_bd_pins CPM2PL_AXI_BRAM/s_axi_aresetn] [get_bd_pins CPM_BRAM_ILA/resetn] [get_bd_pins PL2DDR_CDMA/s_axi_lite_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net CPM_clk_1 [get_bd_ports CPM_clk] [get_bd_pins CPM2PL_AXI_BRAM/s_axi_aclk] [get_bd_pins CPM_BRAM_ILA/clk] [get_bd_pins PL2DDR_CDMA/m_axi_aclk] [get_bd_pins PL2DDR_CDMA/s_axi_lite_aclk] [get_bd_pins axi_noc_INI_CPM_PL/aclk0] [get_bd_pins axi_noc_INI_PL2DDR/aclk0] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net GPIO_LED_MOD_0_GPIO_LED [get_bd_pins GPIO_LED_MOD_0/GPIO_LED] [get_bd_pins util_ds_buf_0/IOBUF_IO_I]
  connect_bd_net -net Net [get_bd_ports GPIO_LED_o] [get_bd_pins util_ds_buf_0/IOBUF_IO_IO]
  connect_bd_net -net pl_clk333mhz_1 [get_bd_ports pl_clk333mhz] [get_bd_pins GPIO_LED_MOD_0/PL_CLK333] [get_bd_pins PS2PL_AXI_BRAM/s_axi_aclk] [get_bd_pins PS_BRAM_ILA/clk] [get_bd_pins axi_dbg_hub_0/aclk] [get_bd_pins axi_noc_0/aclk0] [get_bd_pins axi_noc_INI_PS2PL/aclk0] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net pl_reset_1 [get_bd_ports pl_reset] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins PS2PL_AXI_BRAM/s_axi_aresetn] [get_bd_pins PS_BRAM_ILA/resetn] [get_bd_pins axi_dbg_hub_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins util_ds_buf_0/IOBUF_IO_T] [get_bd_pins xlconstant_2/dout]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces PL2DDR_CDMA/Data] [get_bd_addr_segs PL2DDR_M_AXI_INI/Reg] -force
  assign_bd_address -offset 0x020100000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces CPM2PL_S_AXI_INI] [get_bd_addr_segs CPM2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020100010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CPM2PL_S_AXI_INI] [get_bd_addr_segs PL2DDR_CDMA/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces DBG_HUB_RP] [get_bd_addr_segs axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces PS2PL_S_AXI_INI] [get_bd_addr_segs PS2PL_AXI_BRAM/S_AXI/Mem0] -force

  set_property USAGE memory [get_bd_addr_segs PL2DDR_M_AXI_INI/Reg]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


