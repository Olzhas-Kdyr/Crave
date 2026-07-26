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
)

rm -rf "${remove[@]}"

# Deivce Trees
git clone https://github.com/Olzhas0986-AOSP/device_xiaomi_munch device/xiaomi/munch

# Vendor Trees
git clone --depth=1 https://github.com/Olzhas0986-AOSP/vendor_xiaomi_munch vendor/xiaomi/munch

# Munch Firmware
git clone --depth=1 https://github.com/Olzhas0986-AOSP/vendor_xiaomi_munch-firmware vendor/xiaomi/munch-firmware

# Kernel Tree
git clone --depth=1 https://github.com/Olzhas0986-AOSP/kernel_xiaomi_sm8250 kernel/xiaomi/sm8250

# Hardware Xiaomi
git clone https://github.com/Olzhas0986-AOSP/hardware_xiaomi hardware/xiaomi

# MIUI Camera
git clone --depth=1 https://github.com/Olzhas0986-AOSP/vendor_xiaomi_miuicamera vendor/xiaomi/miuicamera

cd kernel/xiaomi/sm8250
git submodule update --init
cd ../../..

# Building 
. build/envsetup.sh
lunch lineage_munch-bp4a-user
m bacon
