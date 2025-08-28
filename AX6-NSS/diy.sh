#!/bin/bash
# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Add packages
# argon
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#git clone -b js https://github.com/papagaye744/luci-theme-design package/luci-theme-design

# passwall
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf feeds/luci/applications/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall package/passwall-luci

#rm -rf feeds/packages/net/ddns-go
#git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go package/ddnsgo
#rm -rf feeds/packages/net/alist
#git clone --depth 1 https://github.com/sbwml/luci-app-alist package/alist
#git clone --depth 1 https://github.com/sbwml/luci-app-mosdns package/mosdns
#git clone --depth 1  https://github.com/kenzok8/small-package package/small-package


#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-zerotier
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages vlmcsd
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-vlmcsd
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-socat
# 替换luci-app-openvpn-server imm源的启动不了服务！
#rm -rf feeds/luci/applications/luci-app-openvpn-server
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-openvpn-server
# 调整 openvpn-server 到 VPN 菜单
#sed -i 's/services/vpn/g' package/luci-app-openvpn-server/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openvpn-server/luasrc/model/cbi/openvpn-server/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openvpn-server/luasrc/view/openvpn/*.htm
# 替换luci-app-socat为https://github.com/chenmozhijin/luci-app-socat
#rm -rf feeds/luci/applications/luci-app-socat
#git_sparse_clone main https://github.com/chenmozhijin/luci-app-socat luci-app-socat


#修改默认IP
sed -i 's/192.168.1.1/192.168.21.1/g' package/base-files/files/bin/config_generate

#修改主机名
sed -i "s/hostname='ImmortalWrt'/hostname='Redmi-AX6'/g" package/base-files/files/bin/config_generate