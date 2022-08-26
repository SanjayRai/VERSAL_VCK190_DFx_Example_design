/* Sanjay Rai - Routine to access PCIe via  dev.mem mmap  */
#ifndef SRAI_ACCEL_UTILS_H_
#define SRAI_ACCEL_UTILS_H_

#define AXI_MM_DDR4            0x0000000880000000ULL
#define AXI_MM_DDR4_results    0x0000000880000000ULL


/* AXI LITE Register interfaces */
#define AXI_LITE_SCRATCH_PAD_BRAM        0x00000000UL


int fpga_clean (fpga_xdma_dev_mem *my_fpga_ptr);
void fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (fpga_xdma_dev_mem *fpga_AXI_Lite_ptr);
#endif // SRAI_ACCEL_UTILS_H_
