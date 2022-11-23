#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='Zyx-N1Box'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt /编译时间 $(TZ=UTC-8 date "+%Y.%m.%d") @ Zxis /g' package/lean/default-settings/files/zzz-default-settings

# 状态系统增加个性信息
sed -i "s/exit 0//" package/lean/default-settings/files/zzz-default-settings

echo "sed -i '/CPU usage/a\<tr><td width=\"33%\">关于</td><td><a class=\"author-blog\" href=\"http://www.zxis.tk\">作者博客</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://github.com/Zxis233/MI-R4A-breed-openwrt\">编译源地址</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://space.bilibili.com/23311958\">哔哩哔哩</a></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/lean/default-settings/files/zzz-default-settings
echo "sed -i '/关于/a\<tr><td width=\"33%\">天气</td><td><iframe width=\"640\" scrolling=\"no\" height=\"75\" frameborder=\"0\" allowtransparency=\"true\" src=\"https://i.tianqi.com?c=code&id=39&color=%23FF7600&icon=3&num=2&site=12\"></iframe></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/lean/default-settings/files/zzz-default-settings
echo "sed -i '/天气/a\<tr><td width=\"33%\"> </td><td class=\"container\" style=\"height:200px;\"><canvas class=\"illo\" width=\"640\" height=\"640\" style=\"max-width: 200px; max-height: 200px; touch-action: none; width: 640px; height: 640px;\"></canvas></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/lean/default-settings/files/zzz-default-settings

# 嵌入看板娘
#echo "echo '<script src=\"https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/lean/default-settings/files/zzz-default-settings
#echo "echo '<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/font-awesome/css/font-awesome.min.css\"/>' >> /usr/lib/lua/luci/view/footer.htm" >> package/lean/default-settings/files/zzz-default-settings
#echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/stevenjoezhang/live2d-widget/autoload.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/lean/default-settings/files/zzz-default-settings

echo "" >> package/lean/default-settings/files/zzz-default-settings
echo "" >> package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings


#删除原默认主题
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-theme-material
rm -rf package/lean/luci-theme-netgear
rm -rf package/kenzo/luci-theme-ifit

#下载主题luci-theme-argon
git clone https://github.com/Zxis233/luci-theme-ifit.git package/lean/luci-theme-ifit

#取消原主题luci-theme-bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-ifit/g' feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi密码key为password
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

rm package/base-files/files/etc/banner
cp banner package/base-files/files/etc/banner
