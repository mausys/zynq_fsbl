# zynq-fsbl
First Stage Bootloader for the Duebon TEC0097 board:
https://www.duebon-engineering.de/product/zynq-pcie

clone with submodules:
`git clone --recurse-submodules https://github.com/mausys/zynq_fsbl.git`

## Replacing XSA-file
requirements:
- Vivado 2025.2 must be installed

Generate BSP:\
`./sdtgen.sh`

## Build
requirements:
 - cmake 
 - arm-none-eabi-gcc toolchain
 - Xilinx bootgen (comes with Vivado, but is open source, so can be installed directly on some linux distributions) 

`mkdir out`\
`cd out`\
`cmake ..`\
`make`

## Download boot.bin to QSPI flash
requirements:
- Vitis must be installed

`$VITIS_INSTALL_PATH/bin/loader -exec rdi_zynq_flash -f $BUILD_DIR/boot.bin  -fsbl $BUILD_DIR/fsbl.elf -flash_type mt25ql256-qspi-x4-single`


## Boot PC
TEC0097 "Configuration mode select" jumper (S7) must be set to "1 0" (QSPI)

