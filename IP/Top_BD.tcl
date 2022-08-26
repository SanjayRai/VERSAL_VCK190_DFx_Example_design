
################################################################
# This is a generated script based on design: VCK190_top
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
# source VCK190_top_script.tcl


# The design that will be created by this Tcl script contains the following 
# block design container source references:
# user_role

# Please add the sources before sourcing this Tcl script.

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
set design_name VCK190_top

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
xilinx.com:ip:axi_noc:1.0\
xilinx.com:ip:versal_cips:3.2\
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
# CHECK Block Design Container Sources
##################################################################
set bCheckSources 1
set list_bdc_active "user_role"

array set map_bdc_missing {}
set map_bdc_missing(ACTIVE) ""
set map_bdc_missing(BDC) ""

if { $bCheckSources == 1 } {
   set list_check_srcs "\ 
user_role \
"

   common::send_gid_msg -ssname BD::TCL -id 2056 -severity "INFO" "Checking if the following sources for block design container exist in the project: $list_check_srcs .\n\n"

   foreach src $list_check_srcs {
      if { [can_resolve_reference $src] == 0 } {
         if { [lsearch $list_bdc_active $src] != -1 } {
            set map_bdc_missing(ACTIVE) "$map_bdc_missing(ACTIVE) $src"
         } else {
            set map_bdc_missing(BDC) "$map_bdc_missing(BDC) $src"
         }
      }
   }

   if { [llength $map_bdc_missing(ACTIVE)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2057 -severity "ERROR" "The following source(s) of Active variants are not found in the project: $map_bdc_missing(ACTIVE)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(BDC)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2059 -severity "WARNING" "The following source(s) of variants are not found in the project: $map_bdc_missing(BDC)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: Static_region
proc create_hier_cell_Static_region { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_Static_region() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 CPM2PL_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 DBG_HUB_RP

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 PCIE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REFCLK

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:inimm_rtl:1.0 PL2DDR_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:inimm_rtl:1.0 PS2PL_AXI_INI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 ddr4_dimm1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ddr4_dimm1_sma_clk


  # Create pins
  create_bd_pin -dir O -type rst CPM_axi_areset_n
  create_bd_pin -dir O -type clk PCIE_USER_CLK
  create_bd_pin -dir O -type clk pl_clk_333mhz
  create_bd_pin -dir O -type rst pl_resetn

  # Create instance: axi_noc_0, and set properties
  set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
  set_property -dict [ list \
   CONFIG.CH0_DDR4_0_BOARD_INTERFACE {ddr4_dimm1} \
   CONFIG.CONTROLLERTYPE {DDR4_SDRAM} \
   CONFIG.MC_CHAN_REGION1 {DDR_LOW1} \
   CONFIG.MC_COMPONENT_WIDTH {x8} \
   CONFIG.MC_DATAWIDTH {64} \
   CONFIG.MC_INPUTCLK0_PERIOD {5000} \
   CONFIG.MC_INTERLEAVE_SIZE {128} \
   CONFIG.MC_MEMORY_DEVICETYPE {UDIMMs} \
   CONFIG.MC_MEMORY_SPEEDGRADE {DDR4-3200AA(22-22-22)} \
   CONFIG.MC_NO_CHANNELS {Single} \
   CONFIG.MC_RANK {1} \
   CONFIG.MC_ROWADDRESSWIDTH {16} \
   CONFIG.MC_STACKHEIGHT {1} \
   CONFIG.MC_SYSTEM_CLOCK {Differential} \
   CONFIG.NUM_CLKS {11} \
   CONFIG.NUM_MC {1} \
   CONFIG.NUM_MCP {4} \
   CONFIG.NUM_MI {0} \
   CONFIG.NUM_NMI {3} \
   CONFIG.NUM_NSI {1} \
   CONFIG.NUM_SI {9} \
   CONFIG.sys_clk0_BOARD_INTERFACE {ddr4_dimm1_sma_clk} \
 ] $axi_noc_0

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/M00_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/M01_INI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} MC_0 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {100} write_bw {100}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S00_AXI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S00_INI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} M00_INI { read_bw {100} write_bw {100}} MC_1 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S01_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} MC_0 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {100} write_bw {100}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S02_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} M00_INI { read_bw {100} write_bw {100}} MC_1 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S03_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} MC_0 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {100} write_bw {100}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S04_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {M02_INI { read_bw {1720} write_bw {1720}} M00_INI { read_bw {100} write_bw {100}} MC_1 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S05_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M01_INI { read_bw {100} write_bw {100}} MC_2 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_pcie} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S06_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M01_INI { read_bw {100} write_bw {100}} MC_3 { read_bw {100} write_bw {100} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_pcie} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S07_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_INI { read_bw {100} write_bw {100}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /Static_region/axi_noc_0/S08_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk6]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S07_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk7]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk8]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S08_AXI} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk9]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {} \
 ] [get_bd_pins /Static_region/axi_noc_0/aclk10]

  # Create instance: versal_cips_0, and set properties
  set versal_cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.2 versal_cips_0 ]
  set_property -dict [ list \
   CONFIG.CLOCK_MODE {Custom} \
   CONFIG.CPM_CONFIG {\
     CPM_PCIE0_BRIDGE_AXI_SLAVE_IF {0}\
     CPM_PCIE0_MAX_LINK_SPEED {8.0_GT/s}\
     CPM_PCIE0_MODES {DMA}\
     CPM_PCIE0_MODE_SELECTION {Advanced}\
     CPM_PCIE0_MSI_X_OPTIONS {MSI-X_Internal}\
     CPM_PCIE0_NUM_USR_IRQ {1}\
     CPM_PCIE0_PF0_BAR0_XDMA_SCALE {Kilobytes}\
     CPM_PCIE0_PF0_BAR1_XDMA_ENABLED {1}\
     CPM_PCIE0_PF0_BAR1_XDMA_SCALE {Megabytes}\
     CPM_PCIE0_PF0_BAR1_XDMA_SIZE {4}\
     CPM_PCIE0_PF0_MSI_ENABLED {1}\
     CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_1 {0x0000020100000000}\
     CPM_PCIE0_PL_LINK_CAP_MAX_LINK_WIDTH {X8}\
   } \
   CONFIG.DDR_MEMORY_MODE {Custom} \
   CONFIG.DEBUG_MODE {JTAG} \
   CONFIG.DESIGN_MODE {1} \
   CONFIG.PS_BOARD_INTERFACE {ps_pmc_fixed_io} \
   CONFIG.PS_PL_CONNECTIVITY_MODE {Custom} \
   CONFIG.PS_PMC_CONFIG {\
     CLOCK_MODE {Custom}\
     DDR_MEMORY_MODE {Connectivity to DDR via NOC}\
     DEBUG_MODE {JTAG}\
     DESIGN_MODE {1}\
     PCIE_APERTURES_DUAL_ENABLE {0}\
     PCIE_APERTURES_SINGLE_ENABLE {1}\
     PMC_CRP_PL0_REF_CTRL_FREQMHZ {334}\
     PMC_GPIO0_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 0 .. 25}}}\
     PMC_GPIO1_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 26 .. 51}}}\
     PMC_MIO37 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA high}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE GPIO}}\
     PMC_OSPI_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 0 .. 11}} {MODE Single}}\
     PMC_QSPI_COHERENCY {0}\
     PMC_QSPI_FBCLK {{ENABLE 1} {IO {PMC_MIO 6}}}\
     PMC_QSPI_PERIPHERAL_DATA_MODE {x4}\
     PMC_QSPI_PERIPHERAL_ENABLE {1}\
     PMC_QSPI_PERIPHERAL_MODE {Dual Parallel}\
     PMC_REF_CLK_FREQMHZ {33.3333}\
     PMC_SD1 {{CD_ENABLE 1} {CD_IO {PMC_MIO 28}} {POW_ENABLE 1} {POW_IO {PMC_MIO 51}}\
{RESET_ENABLE 0} {RESET_IO {PMC_MIO 12}} {WP_ENABLE 0} {WP_IO {PMC_MIO\
1}}}\
     PMC_SD1_COHERENCY {0}\
     PMC_SD1_DATA_TRANSFER_MODE {8Bit}\
     PMC_SD1_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x3} {CLK_200_SDR_OTAP_DLY 0x2}\
{CLK_50_DDR_ITAP_DLY 0x36} {CLK_50_DDR_OTAP_DLY 0x3}\
{CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x4} {ENABLE\
1} {IO {PMC_MIO 26 .. 36}}}\
     PMC_SD1_SLOT_TYPE {SD 3.0}\
     PMC_USE_PMC_NOC_AXI0 {1}\
     PS_BOARD_INTERFACE {ps_pmc_fixed_io}\
     PS_CAN1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 40 .. 41}}}\
     PS_ENET0_MDIO {{ENABLE 1} {IO {PS_MIO 24 .. 25}}}\
     PS_ENET0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 11}}}\
     PS_ENET1_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 12 .. 23}}}\
     PS_GEN_IPI0_ENABLE {1}\
     PS_GEN_IPI0_MASTER {A72}\
     PS_GEN_IPI1_ENABLE {1}\
     PS_GEN_IPI2_ENABLE {1}\
     PS_GEN_IPI3_ENABLE {1}\
     PS_GEN_IPI4_ENABLE {1}\
     PS_GEN_IPI5_ENABLE {1}\
     PS_GEN_IPI6_ENABLE {1}\
     PS_HSDP_EGRESS_TRAFFIC {JTAG}\
     PS_HSDP_INGRESS_TRAFFIC {JTAG}\
     PS_HSDP_MODE {None}\
     PS_I2C0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 46 .. 47}}}\
     PS_I2C1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 44 .. 45}}}\
     PS_MIO19 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO21 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO7 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_MIO9 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
     PS_NUM_FABRIC_RESETS {1}\
     PS_PCIE1_PERIPHERAL_ENABLE {1}\
     PS_PCIE2_PERIPHERAL_ENABLE {0}\
     PS_PCIE_EP_RESET1_IO {PMC_MIO 38}\
     PS_PCIE_RESET {{ENABLE 1}}\
     PS_PL_CONNECTIVITY_MODE {Custom}\
     PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 42 .. 43}}}\
     PS_USB3_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 13 .. 25}}}\
     PS_USE_FPD_AXI_NOC0 {1}\
     PS_USE_FPD_CCI_NOC {1}\
     PS_USE_FPD_CCI_NOC0 {1}\
     PS_USE_M_AXI_FPD {0}\
     PS_USE_NOC_LPD_AXI0 {1}\
     PS_USE_PMCPL_CLK0 {1}\
     PS_USE_PMCPL_CLK1 {0}\
     PS_USE_PMCPL_CLK2 {0}\
     PS_USE_PMCPL_CLK3 {0}\
     SMON_ALARMS {Set_Alarms_On}\
     SMON_ENABLE_TEMP_AVERAGING {0}\
     SMON_TEMP_AVERAGING_SAMPLES {0}\
   } \
   CONFIG.PS_PMC_CONFIG_APPLIED {0} \
 ] $versal_cips_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins DBG_HUB_RP] [get_bd_intf_pins axi_noc_0/M02_INI]
  connect_bd_intf_net -intf_net S00_INI_0_1 [get_bd_intf_pins PL2DDR_AXI_INI] [get_bd_intf_pins axi_noc_0/S00_INI]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_DDR4_0 [get_bd_intf_pins ddr4_dimm1] [get_bd_intf_pins axi_noc_0/CH0_DDR4_0]
  connect_bd_intf_net -intf_net axi_noc_0_M00_INI [get_bd_intf_pins PS2PL_AXI_INI] [get_bd_intf_pins axi_noc_0/M00_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M01_INI [get_bd_intf_pins CPM2PL_AXI_INI] [get_bd_intf_pins axi_noc_0/M01_INI]
  connect_bd_intf_net -intf_net ddr4_dimm1_sma_clk_1 [get_bd_intf_pins ddr4_dimm1_sma_clk] [get_bd_intf_pins axi_noc_0/sys_clk0]
  connect_bd_intf_net -intf_net gt_refclk0_0_1 [get_bd_intf_pins PCIE_REFCLK] [get_bd_intf_pins versal_cips_0/gt_refclk0]
  connect_bd_intf_net -intf_net versal_cips_0_CPM_PCIE_NOC_0 [get_bd_intf_pins axi_noc_0/S06_AXI] [get_bd_intf_pins versal_cips_0/CPM_PCIE_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_CPM_PCIE_NOC_1 [get_bd_intf_pins axi_noc_0/S07_AXI] [get_bd_intf_pins versal_cips_0/CPM_PCIE_NOC_1]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_AXI_NOC_0 [get_bd_intf_pins axi_noc_0/S08_AXI] [get_bd_intf_pins versal_cips_0/FPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_0 [get_bd_intf_pins axi_noc_0/S00_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_1 [get_bd_intf_pins axi_noc_0/S01_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_1]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_2 [get_bd_intf_pins axi_noc_0/S02_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_2]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_3 [get_bd_intf_pins axi_noc_0/S03_AXI] [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_3]
  connect_bd_intf_net -intf_net versal_cips_0_LPD_AXI_NOC_0 [get_bd_intf_pins axi_noc_0/S04_AXI] [get_bd_intf_pins versal_cips_0/LPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net versal_cips_0_PCIE0_GT [get_bd_intf_pins PCIE] [get_bd_intf_pins versal_cips_0/PCIE0_GT]
  connect_bd_intf_net -intf_net versal_cips_0_PMC_NOC_AXI_0 [get_bd_intf_pins axi_noc_0/S05_AXI] [get_bd_intf_pins versal_cips_0/PMC_NOC_AXI_0]

  # Create port connections
  connect_bd_net -net versal_cips_0_cpm_pcie_noc_axi0_clk [get_bd_pins axi_noc_0/aclk6] [get_bd_pins versal_cips_0/cpm_pcie_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_cpm_pcie_noc_axi1_clk [get_bd_pins axi_noc_0/aclk7] [get_bd_pins versal_cips_0/cpm_pcie_noc_axi1_clk]
  connect_bd_net -net versal_cips_0_dma0_axi_aresetn [get_bd_pins CPM_axi_areset_n] [get_bd_pins versal_cips_0/dma0_axi_aresetn]
  connect_bd_net -net versal_cips_0_fpd_axi_noc_axi0_clk [get_bd_pins axi_noc_0/aclk9] [get_bd_pins versal_cips_0/fpd_axi_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi0_clk [get_bd_pins axi_noc_0/aclk0] [get_bd_pins versal_cips_0/fpd_cci_noc_axi0_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi1_clk [get_bd_pins axi_noc_0/aclk1] [get_bd_pins versal_cips_0/fpd_cci_noc_axi1_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi2_clk [get_bd_pins axi_noc_0/aclk2] [get_bd_pins versal_cips_0/fpd_cci_noc_axi2_clk]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi3_clk [get_bd_pins axi_noc_0/aclk3] [get_bd_pins versal_cips_0/fpd_cci_noc_axi3_clk]
  connect_bd_net -net versal_cips_0_lpd_axi_noc_clk [get_bd_pins axi_noc_0/aclk4] [get_bd_pins versal_cips_0/lpd_axi_noc_clk]
  connect_bd_net -net versal_cips_0_pcie0_user_clk [get_bd_pins PCIE_USER_CLK] [get_bd_pins axi_noc_0/aclk8] [get_bd_pins versal_cips_0/pcie0_user_clk]
  connect_bd_net -net versal_cips_0_pl0_ref_clk [get_bd_pins pl_clk_333mhz] [get_bd_pins axi_noc_0/aclk10] [get_bd_pins versal_cips_0/pl0_ref_clk]
  connect_bd_net -net versal_cips_0_pl0_resetn [get_bd_pins pl_resetn] [get_bd_pins versal_cips_0/pl0_resetn]
  connect_bd_net -net versal_cips_0_pmc_axi_noc_axi0_clk [get_bd_pins axi_noc_0/aclk5] [get_bd_pins versal_cips_0/pmc_axi_noc_axi0_clk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins versal_cips_0/cpm_irq0] [get_bd_pins versal_cips_0/cpm_irq1] [get_bd_pins versal_cips_0/xdma0_usr_irq_in] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins versal_cips_0/dma0_soft_resetn] [get_bd_pins xlconstant_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


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
  set PCIE [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 PCIE ]

  set PCIE_REFCLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REFCLK ]

  set ddr4_dimm1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 ddr4_dimm1 ]

  set ddr4_dimm1_sma_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ddr4_dimm1_sma_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $ddr4_dimm1_sma_clk


  # Create ports
  set GPIO_LED [ create_bd_port -dir IO -from 3 -to 0 GPIO_LED ]

  # Create instance: Static_region
  create_hier_cell_Static_region [current_bd_instance .] Static_region

  # Create instance: user_role_inst_0, and set properties
  set user_role_inst_0 [ create_bd_cell -type container -reference user_role user_role_inst_0 ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {user_role.bd} \
   CONFIG.ACTIVE_SYNTH_BD {user_role.bd} \
   CONFIG.ENABLE_DFX {true} \
   CONFIG.LIST_SIM_BD {user_role.bd} \
   CONFIG.LIST_SYNTH_BD {user_role.bd} \
   CONFIG.LOCK_PROPAGATE {true} \
 ] $user_role_inst_0
  set_property APERTURES {{0x201_0000_0000 128K}} [get_bd_intf_pins /user_role_inst_0/CPM2PL_S_AXI_INI]
  set_property APERTURES {{0x202_0000_0000 2M}} [get_bd_intf_pins /user_role_inst_0/DBG_HUB_RP]
  set_property APERTURES {{0x0 2G} {0x8_0000_0000 8G}} [get_bd_intf_pins /user_role_inst_0/PL2DDR_M_AXI_INI]
  set_property APERTURES {{0x201_8000_0000 128K}} [get_bd_intf_pins /user_role_inst_0/PS2PL_S_AXI_INI]

  # Create interface connections
  connect_bd_intf_net -intf_net Static_region_CPM2PL_AXI_INI [get_bd_intf_pins Static_region/CPM2PL_AXI_INI] [get_bd_intf_pins user_role_inst_0/CPM2PL_S_AXI_INI]
  connect_bd_intf_net -intf_net Static_region_DBG_HUB_RP [get_bd_intf_pins Static_region/DBG_HUB_RP] [get_bd_intf_pins user_role_inst_0/DBG_HUB_RP]
  connect_bd_intf_net -intf_net Static_region_PS2PL_AXI_INI [get_bd_intf_pins Static_region/PS2PL_AXI_INI] [get_bd_intf_pins user_role_inst_0/PS2PL_S_AXI_INI]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_DDR4_0 [get_bd_intf_ports ddr4_dimm1] [get_bd_intf_pins Static_region/ddr4_dimm1]
  connect_bd_intf_net -intf_net ddr4_dimm1_sma_clk_1 [get_bd_intf_ports ddr4_dimm1_sma_clk] [get_bd_intf_pins Static_region/ddr4_dimm1_sma_clk]
  connect_bd_intf_net -intf_net gt_refclk0_0_1 [get_bd_intf_ports PCIE_REFCLK] [get_bd_intf_pins Static_region/PCIE_REFCLK]
  connect_bd_intf_net -intf_net user_role_inst_0_PL2DDR_M_AXI_INI [get_bd_intf_pins Static_region/PL2DDR_AXI_INI] [get_bd_intf_pins user_role_inst_0/PL2DDR_M_AXI_INI]
  connect_bd_intf_net -intf_net versal_cips_0_PCIE0_GT [get_bd_intf_ports PCIE] [get_bd_intf_pins Static_region/PCIE]

  # Create port connections
  connect_bd_net -net CPM_areset_n_1 [get_bd_pins Static_region/CPM_axi_areset_n] [get_bd_pins user_role_inst_0/CPM_areset_n]
  connect_bd_net -net Net [get_bd_ports GPIO_LED] [get_bd_pins user_role_inst_0/GPIO_LED_o]
  connect_bd_net -net Static_region_PCIE_USER_CLK [get_bd_pins Static_region/PCIE_USER_CLK] [get_bd_pins user_role_inst_0/CPM_clk]
  connect_bd_net -net Static_region_pl_clk_333mhz [get_bd_pins Static_region/pl_clk_333mhz] [get_bd_pins user_role_inst_0/pl_clk333mhz]
  connect_bd_net -net Static_region_pl_resetn [get_bd_pins Static_region/pl_resetn] [get_bd_pins user_role_inst_0/pl_reset]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces user_role_inst_0/PL2DDR_CDMA/Data] [get_bd_addr_segs Static_region/axi_noc_0/S00_INI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces user_role_inst_0/PL2DDR_CDMA/Data] [get_bd_addr_segs Static_region/axi_noc_0/S00_INI/C3_DDR_LOW1] -force
  assign_bd_address -offset 0x020100000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs user_role_inst_0/CPM2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020100010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs user_role_inst_0/PL2DDR_CDMA/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S06_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S06_AXI/C2_DDR_LOW1] -force
  assign_bd_address -offset 0x020100000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_1] [get_bd_addr_segs user_role_inst_0/CPM2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020100010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_1] [get_bd_addr_segs user_role_inst_0/PL2DDR_CDMA/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_1] [get_bd_addr_segs Static_region/axi_noc_0/S07_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/CPM_PCIE_NOC_1] [get_bd_addr_segs Static_region/axi_noc_0/S07_AXI/C3_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_AXI_NOC_0] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S00_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S00_AXI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs Static_region/axi_noc_0/S01_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs Static_region/axi_noc_0/S01_AXI/C1_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs Static_region/axi_noc_0/S02_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs Static_region/axi_noc_0/S02_AXI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs Static_region/axi_noc_0/S03_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs Static_region/axi_noc_0/S03_AXI/C1_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S04_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs Static_region/axi_noc_0/S04_AXI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020180000000 -range 0x00008000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs user_role_inst_0/PS2PL_AXI_BRAM/S_AXI/Mem0] -force
  assign_bd_address -offset 0x020200000000 -range 0x00200000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs user_role_inst_0/axi_dbg_hub_0/S_AXI_DBG_HUB/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs Static_region/axi_noc_0/S05_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x000180000000 -target_address_space [get_bd_addr_spaces Static_region/versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs Static_region/axi_noc_0/S05_AXI/C1_DDR_LOW1] -force


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


