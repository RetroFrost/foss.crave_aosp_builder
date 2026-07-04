#!/bin/bash

# 1. Initialize PixelOS 16 Core
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr2 --git-lfs

# 2. Sync Manifest Tree (Maximized threads for Crave Cloud Network)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# 3. Pull Community Exynos 9820 Device / Kernel Sources
git clone https://github.com -b 16.0 device/samsung/beyond2lte
git clone https://github.com -b 16.0 device/samsung/exynos9820-common
git clone https://github.com -b 16.0 kernel/samsung/exynos9820
git clone https://github.com -b 16.0 vendor/samsung/beyond2lte
git clone https://github.com -b 16.0 vendor/samsung/exynos9820-common

# Hardware dependencies to bridge Samsung layer to AOSP
git clone https://github.com -b lineage-23.0 hardware/samsung

# 4. Initialize Build Engine
. build/envsetup.sh

# 5. Lunch Target Configuration and Compile
lunch pixelos_beyond2lte-userdebug
m pixelos -j$(nproc --all)
