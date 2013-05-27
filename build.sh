#!/bin/bash

TOOLCHAIN=/tmp/loki
export SYSROOT=$TOOLCHAIN/sysroot/
# for 32bit
#HOST_SYSTEM=linux-x86
# for 64bit
HOST_SYSTEM=linux-x86_64

NDK_HOME=/home/buildbot/sandbox/tools/android-ndk-r8e
if [ ! -d $TOOLCHAIN ]; then
    echo "--- setup toolchain"
    $NDK_HOME/build/tools/make-standalone-toolchain.sh --system=$HOST_SYSTEM --platform=android-14 --toolchain=arm-linux-androideabi-4.6 --install-dir=$TOOLCHAIN
fi

export PATH=$TOOLCHAIN/bin:$PATH

echo "--- clean up"
make clean

echo "--- make loki_patch"
export CC=gcc
make loki_patch

echo "--- make loki_flash"
export CC=arm-linux-androideabi-gcc
export LD=arm-linux-androideabi-ld
make loki_flash

echo "--- copy out/loki_flash out/loki_patch"
mkdir -p out
mv loki_flash out/
mv loki_patch out/

