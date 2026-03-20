#!/bin/bash

SDTGEN=${SDTGEN:="sdtgen"}

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

#export CUSTOM_SDT_REPO=$ROOT_DIR/system-device-tree-xlnx

EMBEDDEDSW_DIR=$SCRIPT_DIR/embeddedsw
XSA_FILE=$SCRIPT_DIR/hw/tec0097/release/pcie.xsa
GEN_DIR=$SCRIPT_DIR/gen
BSP_OUT_DIR=$GEN_DIR/bsp
XSA_OUT_DIR=$GEN_DIR/xsa

mkdir $GEN_DIR
cd $GEN_DIR

"$SDTGEN" -eval "hsi set_repo_path $EMBEDDEDSW_DIR; hsi open_hw_design -outdir $XSA_OUT_DIR -name zynq_pcie $XSA_FILE; hsi generate_bsp -proc ps7_cortexa9_0 -hw zynq_pcie  -dir $BSP_OUT_DIR -os standalone; hsi close_hw_design zynq_pcie"
cp $BSP_OUT_DIR/ps7_cortexa9_0/libsrc/standalone_v9_4/src/outbyte.c $GEN_DIR
cp $BSP_OUT_DIR/ps7_cortexa9_0/include/xparameters.h $GEN_DIR
cp $BSP_OUT_DIR/ps7_cortexa9_0/libsrc/standalone_v9_4/src/bspconfig.h $GEN_DIR
