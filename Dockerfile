FROM nvcr.io/nvidia/jetpack-linux-aarch64-crosscompile-x86:5.1.2
 
RUN apt update && apt install -y -qq emacs git wget
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /l4t
RUN tar -I lbzip2 -xf targetfs.tbz2 && mkdir toolchain && tar -C toolchain -xf toolchain.tar.gz
RUN wget https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v4.1/sources/public_sources.tbz2
RUN tar xvf public_sources.tbz2
 
WORKDIR /l4t/Linux_for_Tegra/source/public
RUN CROSS_COMPILE_AARCH64_PATH=/l4t/toolchain NV_TARGET_BOARD=t186ref ./nv_public_src_build.sh
 
WORKDIR /l4t/Linux_for_Tegra/source/src_out/kernel_src_build/kernel/kernel-5.10
RUN make ARCH=arm64 CROSS_COMPILE=/l4t/toolchain/bin/aarch64-buildroot-linux-gnu- tegra_defconfig
RUN make ARCH=arm64 CROSS_COMPILE=/l4t/toolchain/bin/aarch64-buildroot-linux-gnu- modules_prepare
 
RUN mkdir -p /lib/modules/5.10.120-tegra
RUN ln -sf /l4t/Linux_for_Tegra/source/src_out/kernel_src_build/kernel/kernel-5.10 /lib/modules/5.10.120-tegra/build
RUN ln -sf /l4t/Linux_for_Tegra/source/src_out/kernel_src_build/kernel/kernel-5.10 /lib/modules/5.10.120-tegra/source
 
ENV CROSS_COMPILE=/l4t/toolchain/bin/aarch64-buildroot-linux-gnu-
ENV ARCH=arm64
 
COPY prebuild_kernel_module.sh /l4t
 
WORKDIR /l4t
