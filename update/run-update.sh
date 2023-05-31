#wget https://github.com/${GitUser}/
GitUser="Kulanbagong1"
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
echo ""
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf )
clear
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}($version)${Font_color_suffix}"
Info2="${Green_font_prefix}(LATEST VERSION)${Font_color_suffix}"
Error="Version ${Green_font_prefix}[$ver]${Font_color_suffix} available${Red_font_prefix}[Please Update]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf | grep $version )
#Status Version
if [ $version = $new_version ]; then
sts="${Info2}"
else
sts="${Error}"
fi
clear
echo ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$back_text                 \e[30m[\e[$box CHECK NEW UPDATE\e[30m ]                   \e[m"
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$below VERSION NOW >> $Info1"
echo -e "   \e[$below STATUS UPDATE >> $sts"
echo -e ""
echo -e "       \e[1;31mWould you like to proceed?\e[0m"
echo ""
echo -e "            \e[0;32m[ Select Option ]\033[0m"
echo -e "     \e[$number [1]\e[m \e[$below Check Script Update Now\e[m"
echo -e "     \e[$number [x]\e[m \e[$below Back To Update Menu\e[m"
echo -e "     \e[$number [y]\e[m \e[$below Back To Main Menu\e[m"
echo -e ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "\e[$line"
read -p "Please Choose 1 or x & y : " option2
case $option2 in
1)
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf | grep $version )
if [ $version = $new_version ]; then
clear
echo ""
echo -e "\e[1;31mChecking New Version, Please Wait...!\e[m"
sleep 3
clear
echo -e "\e[1;31mUpdate Not Available\e[m"
echo ""
clear
sleep 1
echo -e "\e[1;36mYou Have The Latest Version\e[m"
echo -e "\e[1;31mThankyou.\e[0m"
sleep 2
update
fi
clear
echo -e "\e[1;31mUpdate Available Now..\e[m"
echo -e ""
sleep 2
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script..\e[0m"
sleep 1
echo ""
# UPDATE RUN-UPDATE
cd /usr/bin
wget -O run-update "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/update/run-update.sh"
chmod +x run-update
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
sleep 6
clear
echo ""
echo -e "\e[0;32mNew Version Downloading started!\e[0m"
sleep 2
cd /usr/bin
wget -O update "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/update/update.sh"
wget -O run-update "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/update/run-update.sh"
wget -O message-ssh "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/update/message-ssh.sh"
#wget -O change-port "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/change.sh"
wget -O system "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/menu/system.sh"
wget -O menu "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/menu.sh"
wget -O add-host "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/add-host.sh"
wget -O check-sc "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/running.sh"
wget -O cert "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/cert.sh"
#wget -O trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/trojan.sh"
#wget -O vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/vmess.sh"
#wget -O vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/vless.sh"
#wget -O sowdowsoks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/sowdowsoks/sowdowsoks.sh"
#wget -O sowdowsoks2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/sowdowsok2022/sowdowsoks2022.sh"
#wget -O socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/socks.sh"
wget -O vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/vmess.sh"
wget -O add-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/add-vmess.sh"
wget -q -O del-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/del-vmess.sh"
wget -O extend-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/extend-vmess.sh"
wget -O trialvmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/trialvmess.sh"
wget -O cek-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/cek-vmess.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vless${NC}"
wget -O vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/vless.sh"
wget -O add-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/add-vless.sh"
wget -O del-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/del-vless.sh"
wget -O extend-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/extend-vless.sh"
wget -O trialvless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/trialvless.sh"
wget -O cek-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/cek-vless.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojan${NC}"
wget -O trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/trojan.sh"
wget -O add-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/add-trojan.sh"
wget -O del-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/del-trojan.sh"
wget -O extend-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/extend-trojan.sh"
wget -O trialtrojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/trialtrojan.sh"
wget -O cek-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/cek-trojan.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks${NC}"
wget -O sowdowsok "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowshoks/sowdowsok.sh"
wget -O add-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/add-ss.sh"
wget -O del-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/del-ss.sh"
wget -O extend-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/extend-ss.sh"
wget -O trialss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/trialss.sh"
wget -O cek-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/cek-ss.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks 2022${NC}"
wget -O shadowsocks2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/shadowsocks2022.sh"
wget -O add-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/add-ss2022.sh"
wget -O del-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/del-ss2022.sh"
wget -O extend-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/extend-ss2022.sh"
wget -O trialss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/trialss2022.sh"
wget -O cek-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/cek-ss2022.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -O socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/socks.sh"
wget -O add-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/add-socks.sh"
wget -O del-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/del-socks.sh"
wget -O extend-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/extend-socks.sh"
wget -O trialsocks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/trialsocks.sh"
wget -O cek-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/cek-socks.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu All Xray${NC}"
wget -O allxray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/allxray.sh"
wget -O add-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/add-xray.sh"
wget -O del-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/del-xray.sh"
wget -O extend-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/extend-xray.sh"
wget -O trialxray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/trialxray.sh"
wget -O cek-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/cek-xray.sh"
#sleep 0.5
#Prot
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/change-port/port-xray.sh"
wget -O certv2ray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/cert.sh"


wget -O xp "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/xp.sh"
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/change-port/port-xray.sh"
wget -O themes "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/menu/themes.sh"
wget -O autobackup "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/autobackup.sh"
wget -O backup "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/backup.sh"
wget -O bckp "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/bckp.sh"
wget -O restore "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/system/restore.sh"
chmod +x update
chmod +x run-update
chmod +x message-ssh
chmod +x change-port
chmod +x system
chmod +x menu
chmod +x add-host
chmod +x check-sc
chmod +x cert
#chmod +x trojan
#chmod +x vmess
#chmod +x vless
#chmod +x sowdowsoks
#chmod +x sowdowsok2022
#chmod +x socks
chmod +x xp
#chmod +x port-xray
chmod +x themes
chmod +x autobackup
chmod +x backup
chmod +x bckp
chmod +x restore
chmod +x add-vmess
chmod +x del-vmess
chmod +x extend-vmess
chmod +x trialvmess
chmod +x cek-vmess
chmod +x add-vless
chmod +x del-vless
chmod +x extend-vless
chmod +x trialvless
chmod +x cek-vless
chmod +x add-trojan
chmod +x del-trojan
chmod +x extend-trojan
chmod +x trialtrojan
chmod +x cek-trojan
chmod +x add-ss
chmod +x del-ss
chmod +x extend-ss
chmod +x trialss
chmod +x cek-ss
chmod +x add-ss2022
chmod +x del-ss2022
chmod +x extend-ss2022
chmod +x trialss2022
chmod +x cek-ss2022
chmod +x add-socks
chmod +x del-socks
chmod +x extend-socks
chmod +x trialsocks
chmod +x cek-socks
chmod +x add-xray
chmod +x del-xray
chmod +x extend-xray
chmod +x trialxray
chmod +x cek-xray
chmod +x vmess
chmod +x vless
chmod +x trojan
chmod +x sowdowsok
chmod +x shadowsocks2022
chmod +x socks
chmod +x allxray
chmod +x port-xray
chmod +x certv2ray
clear
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
echo ""
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf )
sleep 1
echo -e "\e[0;32mPatching New Update, Please Wait...\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mPatching... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mSucces Update Script For New Version\e[0m"
cd
echo "$ver" > /home/ver
rm -f update.sh
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m            SCRIPT UPDATED              \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
update
;;
y)
clear
menu
;;
*)
clear
echo -e "\e[1;31mPlease Enter Option 1-2 or x & y Only..,Try again, Thank You..\e[0m"
sleep 2
run-update
;;
esac
