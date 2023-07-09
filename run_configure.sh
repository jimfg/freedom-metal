#! /bin/sh
# do the ./configure, create Makefile
BSP_DIR=$(pwd)/../bsp-hifive1-revb
METAL_BUILD_DIR=${BSP_DIR}/build/debug
METAL_SOURCE_PATH=$(pwd)

RV_CFLAGS="-march=rv32imaczicsr_zifencei -mabi=ilp32 -mcmodel=medlow \
	-ffunction-sections -fdata-sections --specs=nano.specs \
	-DMTIME_RATE_HZ_DEF=32768 -O0 -g"

rm -rf ${METAL_BUILD_DIR}
mkdir -p ${METAL_BUILD_DIR}
cd ${METAL_BUILD_DIR}
CFLAGS="${RV_CFLAGS}" ${METAL_SOURCE_PATH}/configure \
	--host=riscv32-unknown-elf \
	--prefix=${BSP_DIR}/install \
	--libdir=${BSP_DIR}/install/lib/debug \
	--with-builtin-libgloss \
	--with-machine-header=${BSP_DIR}/metal.h \
	--with-machine-inline=${BSP_DIR}/metal-inline.h \
	--with-platform-header=${BSP_DIR}/metal-platform.h
