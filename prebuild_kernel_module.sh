#!/usr/bin/env sh
 
set -e
 
mkdir /lib/modules/$(uname -r)
ln -sf /l4t/Linux_for_Tegra/source/src_out/kernel_src_build/kernel/kernel-5.10 /lib/modules/$(uname -r)/build

