# repo init
rm -rf .repo/manifests
rm -rf .repo/local_manifests
rm -rf .repo/manifest
repo init -u https://github.com/Lineage-Olzhas/manifest.git -b lineage-23.2 --git-lfs --depth 1

# repo sync script
/opt/crave/resync.sh

# Remove old device specific repos
remove=(
device/xiaomi
kernel/xiaomi
vendor/xiaomi
hardware/xiaomi
vendor/lineage-priv/keys
out/target/product/munch
packages/apps/Launcher3
)

rm -rf "${remove[@]}"

# Deivce Trees
git clone https://github.com/olzhas0986/android_device_xiaomi_munch device/xiaomi/munch

# Vendor Trees
git clone --depth=1 https://github.com/olzhas0986/android_vendor_xiaomi_munch vendor/xiaomi/munch

# Munch Firmware
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_munch-firmware.git vendor/xiaomi/munch-firmware

# Kernel Tree
git clone --depth=1 https://github.com/olzhas0986/kernel_xiaomi_munch -b staging kernel/xiaomi/munch

# Hardware Xiaomi
git clone https://github.com/crdroidandroid/android_hardware_xiaomi -b 16.0 hardware/xiaomi

# MIUI Camera
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera.git vendor/xiaomi/miuicamera

# My Keys
git clone https://github.com/olzhas0986/keys vendor/lineage-priv/keys

git clone https://github.com/olzhas0986/android_packages_apps_Launcher3 packages/apps/Launcher3

cd kernel/xiaomi/munch
git submodule update --init
rm -rf KernelSU-Next/userspace/su
cd ../../..

# Building 
. build/envsetup.sh
lunch lineage_munch-bp4a-user
m bacon
