# The Kernel Module builder for NVIDIA Jetson

Container environment for building Kernel Module for NVIDIA Tegra Linux. This repository allows cross-compilation on x86-architecture computers, rather than on the aarch64-architecture Jetson, which has limited computing resources.

# Build the docker image

```shell
docker build -t tegra-kernel-module-builder .
```

# Build the sample kernel module

```shell
git submodule update --init --recursive
docker run --rm -v $(pwd)/example_modules:/l4t/example_modules tegra-kernel-module-builder:latest /bin/bash -c "./prebuild_kernel_module.sh && cd example_modules/rtl8812au && make -j modules"
```
