# repo init
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs --depth 1

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
git clone https://github.com/olzhas0986/android_device_xiaomi_munch -b 16.2-Rebased device/xiaomi/munch

# Vendor Trees
git clone --depth=1 https://github.com/olzhas0986/android_vendor_xiaomi_munch -b 16.2-Rebased vendor/xiaomi/munch

# Munch Firmware
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_munch-firmware.git vendor/xiaomi/munch-firmware

# Kernel Tree
git clone --depth=1 https://github.com/olzhas0986/android_kernel_xiaomi_sm8250 -b new kernel/xiaomi/sm8250

# Hardware Xiaomi
git clone https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi

# MIUI Camera
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera.git vendor/xiaomi/miuicamera

cd kernel/xiaomi/sm8250
git submodule update --init
rm -rf KernelSU-Next/userspace/su
cd ../../..

# Building 
. build/envsetup.sh
lunch lineage_munch-bp4a-user
m bacon
