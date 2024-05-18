#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#Modify hostname
sed -i 's/OpenWrt/2077S-X/g' package/base-files/files/bin/config_generate

#Modify wan
sed -i '/config interface 'wan'/,/^$/ s/option proto .*/option proto 'dhcp'/' package/base-files/files/etc/config/network

# Modify startup
sed -i '/^exit 0/i ip link set ra0 up' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i ip link set rai0 up' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i brctl addif br-lan ra0' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i brctl addif br-lan rai0' package/base-files/files/etc/rc.local
