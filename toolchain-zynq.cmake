set(CMAKE_SYSTEM_PROCESSOR "cortexa9")
set(CMAKE_MACHINE "Zynq")
set(CMAKE_SYSTEM_NAME "Generic")

set(CMAKE_C_COMPILER arm-none-eabi-gcc )
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc )
set(ARCH_FLAGS "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard")
set(CMAKE_C_FLAGS "${ARCH_FLAGS} -nostartfiles -fno-tree-loop-distribute-patterns -O2 -g -Wall -Wextra")
set(CMAKE_ASM_FLAGS "${ARCH_FLAGS}")

set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
