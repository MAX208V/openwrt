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

#修改 主机名为 "2077S-X"
sed -i 's/OpenWrt/2077S-X/g' package/base-files/files/bin/config_generate

# 设置 root 密码
sed -i 's/root::0:0:99999:7:::/${{ secrets.ROOT_PASSWORD }}/g' package/base-files/files/etc/shadow

#修改 WAN 协议为 "DHCP"
sed -i '/config interface 'wan'/,/^$/ s/option proto .*/option proto 'dhcp'/' package/base-files/files/etc/config/network

# 修改2.4GHz WLAN 名称为 "2077S-X"
sed -i 's/set wireless.default_radio${devidx}.ssid=OpenWrt/set wireless.default_radio0.ssid=2077S-X/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改5GHz WLAN 名称为 "2077S-X_5G"
sed -i 's/set wireless.default_radio${devidx}.ssid=OpenWrt/set wireless.default_radio1.ssid=2077S-X_5G/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改2.4GHz WLAN 密码
sed -i 's/set wireless.default_radio${devidx}.key=${{ secrets.WIFI_PASSWORD }}/set wireless.default_radio0.key=14758900/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改5GHz WLAN 密码
sed -i 's/set wireless.default_radio${devidx}.key=${{ secrets.WIFI_PASSWORD }}/set wireless.default_radio1.key=14758900/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改 无线 状态为 开机启动
sed -i '/^exit 0/i ip link set ra0 up' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i ip link set rai0 up' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i brctl addif br-lan ra0' package/base-files/files/etc/rc.local
sed -i '/^exit 0/i brctl addif br-lan rai0' package/base-files/files/etc/rc.local
