# Copyright (C) 2023 - 2025 Advanced Micro Devices, Inc.  All rights reserved.
# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 4.0)

set( CMAKE_SYSTEM_PROCESSOR "cortexa9" )
set( CMAKE_MACHINE "Zynq" )
set( CMAKE_SYSTEM_NAME "Generic" )




set(EMBEDDEDSW_DIR ${CMAKE_CURRENT_SOURCE_DIR}/embeddedsw)
set(XSA_DIR ${CMAKE_CURRENT_SOURCE_DIR}/xsa)
set(FSBL_SRC_DIR ${EMBEDDEDSW_DIR}/lib/sw_apps/zynq_fsbl/src)
set(BSP_SRC_DIR ${EMBEDDEDSW_DIR}/lib/bsp/standalone/src)
set(BSP_GEN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bsp/ps7_cortexa9_0)

set(DRIVERS_DIR ${EMBEDDEDSW_DIR}/XilinxProcessorIPLib/drivers)


set(CMAKE_C_COMPILER arm-none-eabi-gcc )
set(CMAKE_CXX_COMPILER arm-none-eabi-g++ )
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc )
set(CMAKE_AR arm-none-eabi-ar  )
set(CMAKE_SIZE arm-none-eabi-size )
set(ARCH_FLAGS -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard)
set(EXTRA_C_FLAGS -O2 -g -Wall -Wextra -nostartfiles -fno-tree-loop-distribute-patterns)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(fsbl LANGUAGES C ASM )


set(START_SRC
	${BSP_SRC_DIR}/arm/cortexa9/gcc/asm_vectors.S
	${BSP_SRC_DIR}/arm/cortexa9/gcc/boot.S
	${BSP_SRC_DIR}/arm/cortexa9/gcc/cpu_init.S
	${BSP_SRC_DIR}/arm/cortexa9/gcc/translation_table.S
	${BSP_SRC_DIR}/arm/cortexa9/gcc/xil-crt0.S)

set(BSP_SRCS
	${BSP_SRC_DIR}/common/print.c
	${BSP_SRC_DIR}/common/xil_assert.c
	${BSP_SRC_DIR}/common/xil_mem.c
	${BSP_SRC_DIR}/common/xil_printf.c
	${BSP_SRC_DIR}/common/xil_testcache.c
	${BSP_SRC_DIR}/common/xil_testio.c
	${BSP_SRC_DIR}/common/xil_util.c
	${BSP_SRC_DIR}/common/xil_sutil.c
	${BSP_SRC_DIR}/common/xplatform_info.c
	${BSP_SRC_DIR}/common/outbyte.c
	${BSP_SRC_DIR}/common/inbyte.c
	${BSP_SRC_DIR}/common/xpm_init.c
	${BSP_SRC_DIR}/common/xil_sleepcommon.c
	${BSP_SRC_DIR}/common/intr/xinterrupt_wrap.c
	${BSP_SRC_DIR}/arm/common/putnum.c
	${BSP_SRC_DIR}/arm/common/vectors.c
	${BSP_SRC_DIR}/arm/common/xil_exception.c
	${BSP_SRC_DIR}/arm/common/xil_spinlock.c
	${BSP_SRC_DIR}/arm/common/xpm_counter.c
	${BSP_SRC_DIR}/arm/common/gcc/cpputest_time.c
	${BSP_SRC_DIR}/arm/common/gcc/read.c
	${BSP_SRC_DIR}/arm/common/gcc/unlink.c
	${BSP_SRC_DIR}/arm/common/gcc/sbrk.c
	${BSP_SRC_DIR}/arm/common/gcc/isatty.c
	${BSP_SRC_DIR}/arm/common/gcc/_sbrk.c
	${BSP_SRC_DIR}/arm/common/gcc/_exit.c
	${BSP_SRC_DIR}/arm/common/gcc/fcntl.c
	${BSP_SRC_DIR}/arm/common/gcc/close.c
	${BSP_SRC_DIR}/arm/common/gcc/write.c
	${BSP_SRC_DIR}/arm/common/gcc/getpid.c
	${BSP_SRC_DIR}/arm/common/gcc/fstat.c
	${BSP_SRC_DIR}/arm/common/gcc/open.c
	${BSP_SRC_DIR}/arm/common/gcc/errno.c
	${BSP_SRC_DIR}/arm/common/gcc/_open.c
	${BSP_SRC_DIR}/arm/common/gcc/abort.c
	${BSP_SRC_DIR}/arm/common/gcc/kill.c
	${BSP_SRC_DIR}/arm/common/gcc/lseek.c
	${BSP_SRC_DIR}/arm/common/gcc/getentropy.c
	${BSP_SRC_DIR}/arm/common/gcc/gettimeofday.c
	${BSP_SRC_DIR}/arm/common/gcc/time.c
	${BSP_SRC_DIR}/arm/cortexa9/xil_cache.c
	${BSP_SRC_DIR}/arm/cortexa9/xil_misc_psreset_api.c
	${BSP_SRC_DIR}/arm/cortexa9/xil_mmu.c
	${BSP_SRC_DIR}/arm/cortexa9/usleep.c
	${BSP_SRC_DIR}/arm/cortexa9/xtime_l.c
	${BSP_SRC_DIR}/arm/cortexa9/sleep.c
	${BSP_SRC_DIR}/arm/cortexa9/usleep.c)


set(BSP_INC
	${BSP_SRC_DIR}/common
	${BSP_SRC_DIR}/arm/cortexa9
	${BSP_SRC_DIR}/arm/common
	${BSP_SRC_DIR}/arm/common/gcc)


set(DRV_SRCS
	${DRIVERS_DIR}/devcfg/src/xdevcfg.c
	${DRIVERS_DIR}/devcfg/src/xdevcfg_hw.c
	${DRIVERS_DIR}/devcfg/src/xdevcfg_intr.c
	${DRIVERS_DIR}/devcfg/src/xdevcfg_selftest.c
	${DRIVERS_DIR}/devcfg/src/xdevcfg_sinit.c

	${DRIVERS_DIR}/uartps/src/xuartps_hw.c
	${DRIVERS_DIR}/uartps/src/xuartps_selftest.c
	${DRIVERS_DIR}/uartps/src/xuartps_intr.c
	${DRIVERS_DIR}/uartps/src/xuartps.c
	${DRIVERS_DIR}/uartps/src/xuartps_sinit.c
	${DRIVERS_DIR}/uartps/src/xuartps_options.c

	${DRIVERS_DIR}/qspips/src/xqspips.c
	${DRIVERS_DIR}/qspips/src/xqspips_hw.c
	${DRIVERS_DIR}/qspips/src/xqspips_options.c
	${DRIVERS_DIR}/qspips/src/xqspips_selftest.c
	${DRIVERS_DIR}/qspips/src/xqspips_sinit.c)

set(DRV_INC
	${DRIVERS_DIR}/devcfg/src
	${DRIVERS_DIR}/uartps/src
	${DRIVERS_DIR}/qspips/src)

set(BSP_GEN_SRCS
	${BSP_GEN_DIR}/libsrc/standalone_v9_4/src/outbyte.c
	${BSP_GEN_DIR}/libsrc/qspips_v3_14/src/xqspips_g.c
	${BSP_GEN_DIR}/libsrc/devcfg_v3_9/src/xdevcfg_g.c)

set(BSP_GEN_INC
	${BSP_GEN_DIR}/include)


set(FSBL_SRCS
	${FSBL_SRC_DIR}/fsbl_hooks.c
	${FSBL_SRC_DIR}/image_mover.c
	${FSBL_SRC_DIR}/md5.c
	${FSBL_SRC_DIR}/nand.c
	${FSBL_SRC_DIR}/nor.c
	${FSBL_SRC_DIR}/pcap.c
	${FSBL_SRC_DIR}/qspi.c
	${FSBL_SRC_DIR}/rsa.c
	${FSBL_SRC_DIR}/fsbl_handoff.S
	${CMAKE_CURRENT_SOURCE_DIR}/main.c
	${XSA_DIR}/ps7_init.c)

set(FSBL_INC
	${FSBL_SRC_DIR}
	${BSP_GEN_SRC_DIR}
	${BSP_GEN_INC}
	${XSA_DIR}
	${EMBEDDEDSW_DIR}/lib/sw_services/xiltimer/src
	${EMBEDDEDSW_DIR}/lib/sw_services/xilffs/src/include)


add_library(bsp STATIC
	${DRV_SRCS}
	${BSP_SRCS})


target_compile_options(bsp PUBLIC ${ARCH_FLAGS} ${EXTRA_C_FLAGS})
target_include_directories(bsp PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${BSP_INC} ${DRV_INC} ${FSBL_INC})

add_executable(${CMAKE_PROJECT_NAME}.elf ${START_SRC} ${BSP_GEN_SRCS} ${FSBL_SRCS})
add_dependencies( ${CMAKE_PROJECT_NAME}.elf bsp )


target_compile_options(${CMAKE_PROJECT_NAME}.elf PUBLIC ${ARCH_FLAGS} ${EXTRA_C_FLAGS})
target_include_directories(${CMAKE_PROJECT_NAME}.elf PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${BSP_GEN_INC} ${BSP_INC} ${DRV_INC} ${FSBL_INC})
target_link_libraries(${CMAKE_PROJECT_NAME}.elf ${ARCH_FLAGS} -specs=${FSBL_SRC_DIR}/../misc/Xilinx.spec   -L${PROJECT_BINARY_DIR} -Wl,-build-id=none -Wl,--start-group,-lbsp,-lgcc,-lc,--end-group -Wl,--gc-sections -Wl,--start-group,-lbsp,-lgcc,-lc,--end-group -T${FSBL_SRC_DIR}/lscript.ld)

file(GENERATE OUTPUT boot.bif
	CONTENT
	"the_ROM_image:
		{
		[bootloader]${CMAKE_PROJECT_NAME}.elf
		${CMAKE_CURRENT_SOURCE_DIR}/xsa/TOP_wrapper.bit
		}
	"
	)

add_custom_command(OUTPUT boot.bin COMMAND bootgen -arch zynq -image boot.bif -o boot.bin DEPENDS boot.bif ${CMAKE_PROJECT_NAME}.elf)
add_custom_target(create_boot_bin ALL DEPENDS boot.bin)
