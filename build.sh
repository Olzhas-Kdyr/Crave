# repo init
repo init -u https://github.com/The-Clover-Project/manifest.git -b 16-qpr2 --git-lfs

# repo sync script
/opt/crave/resync.sh

# Remove old device specific repos
remove=(
device/xiaomi
kernel/xiaomi
vendor/xiaomi
hardware/xiaomi
vendor/lineage-priv/keys
vendor/clover-priv/keys
out/target/product/munch
)

rm -rf "${remove[@]}"

# Deivce Trees
git clone --depth=1 https://github.com/olzhas0986/android_device_xiaomi_munch -b clover-16 device/xiaomi/munch
git clone --depth=1 https://github.com/olzhas0986/android_device_xiaomi_sm8250-common.git -b clover-16-qpr2 device/xiaomi/sm8250-common

# Vendor Trees
git clone --depth=1 https://github.com/olzhas0986/android_vendor_xiaomi_munch vendor/xiaomi/munch
git clone --depth=1 https://github.com/olzhas0986/android_vendor_xiaomi_sm8250-common vendor/xiaomi/sm8250-common

# Munch Firmware
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_munch-firmware.git vendor/xiaomi/munch-firmware

# Kernel Tree
git clone --depth=1 https://github.com/olzhas0986/magictime_sm8250_ximi -b aosp-16 kernel/xiaomi/sm8250

# Hardware Xiaomi
git clone --depth=1 https://github.com/olzhas0986/android_hardware_xiaomi -b aosp-16 hardware/xiaomi

# MIUI Camera
git clone --depth=1 https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera.git vendor/xiaomi/miuicamera

# My Keys
git clone --depth=1 https://github.com/olzhas0986/keys -b cl vendor/lineage-priv/keys

# Soong
git clone --depth=1 https://github.com/olzhas0986/build_soong-clover -b 16-qpr2 build/soong

# Building 
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
make installclean
lunch clover_munch-bp4a-user
mka clover