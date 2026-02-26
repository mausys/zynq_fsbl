#!/bin/bash

SDTGEN=${SDTGEN:="sdtgen"}

ROOT_DIR=$(dirname "$0")

#export CUSTOM_SDT_REPO=$ROOT_DIR/system-device-tree-xlnx
 
BSP_OUT_DIR=$ROOT_DIR/bsp
XSA_OUT_DIR=$ROOT_DIR/xsa
XSA_FILE=$ROOT_DIR/TOP_wrapper.xsa
EMBEDDEDSW_DIR=$ROOT_DIR/embeddedsw

"$SDTGEN" -eval "hsi set_repo_path $EMBEDDEDSW_DIR; hsi open_hw_design -outdir $XSA_OUT_DIR -name zynq_pcie $XSA_FILE; hsi generate_bsp -proc ps7_cortexa9_0 -hw zynq_pcie  -dir $BSP_OUT_DIR -os standalone; hsi close_hw_design zynq_pcie"
