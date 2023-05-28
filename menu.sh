#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Kulanbagong1"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
#Domain
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
WKT=$(curl -s ipinfo.io/timezone)
IPVPS=$(curl -s ipinfo.io/ip)
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# USERNAME
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
# Order ID
rm -f /usr/bin/ver
user=$(curl https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $3}')
echo "$user" >/usr/bin/ver
# validity
rm -f /usr/bin/e
valid=$(curl https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $4}')
echo "$valid" >/usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf )
clear
# Warna
RED='\033[0;31m'
NC='\e[0m'
gray="\e[1;30m"
Blue="\033[1;36m"
GREEN='\033[0;32m'
grenbo="\033[1;95m"
YELL='\033[1;33m'
BGX="\033[42m"
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}($version)${Font_color_suffix}"
Info2="${Green_font_prefix}(LATEST VERSION)${Font_color_suffix}"
Error="Version ${Green_font_prefix}[$ver]${Font_color_suffix} available${Red_font_prefix}[Please Update]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf | grep $version )
#Status Version
if [ $version = $new_version ]; then
stl="${Info2}"
else
stl="${Error}"
fi
clear
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Active)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=$(date -d "0 days" +"%Y-%m-%d")
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

status="$(systemctl status xray)"
status_xray=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $status_xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

haproxy=$( systemctl status haproxy | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_haproxy="${GREEN}ON${NC}"
else
    status_haproxy="${RED}OFF${NC}"
fi

#Install UDP
UDPCORE="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e "\e[$text VPS Script"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                    \e[30m[\e[$box SERVER INFORMATION\e[30m ]\e[1m                  \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$text Cpu Model            :$cname"
echo -e "  \e[$text Cpu Frequency        :$freq MHz"
echo -e "  \e[$text Number Of Core       : $cores"
echo -e "  \e[$text CPU Usage            : $cpu_usage"
echo -e "  \e[$text Operating System     : "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)
echo -e "  \e[$text Kernel               : $(uname -r)"
echo -e "  \e[$text Total Amount Of Ram  : $tram MB"
echo -e "  \e[$text Used RAM             : $uram MB"
echo -e "  \e[$text Free RAM             : $fram MB"
echo -e "  \e[$text System Uptime        : $uptime"
echo -e "  \e[$text Ip Vps/Address       : $IPVPS"
echo -e "  \e[$text Domain Name          : $domain\e[0m"
echo -e "  \e[$text Order ID             : $oid"
echo -e "  \e[$text Expired Status       : $exp $sts"
echo -e "  \e[$text Provided By          : JENGKOLONLINE VPN"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$text Traffic\e[0m       \e[${text}Today      Yesterday        Month   "
echo -e "  \e[$text Download\e[0m   \e[${text}   $dtoday    $dyest       $dmon   \e[0m"
echo -e "  \e[$text Upload\e[0m     \e[${text}   $utoday    $uyest       $umon   \e[0m"
echo -e "  \e[$text Total\e[0m       \e[${text}  $ttoday    $tyest       $tmon  \e[0m "
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  ${Blue}XRAY${NC}: [ ${status_xray} ]     ${Blue}NGINX${NC}: [ ${status_nginx} ${NC} ]   ${Blue}HAPROXY${NC}: [ ${status_haproxy} ${NC}]"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                        \e[30m[\e[$box PANEL MENU\e[30m ]\e[1m                       \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$number (•1)\e[m \e[$below SSHWS & OPENVPN\e[m    \e[$number (•5)\e[m \e[$below TROJAN GO\e[m"
echo -e "  \e[$number (•2)\e[m \e[$below VMESS gRPC & WS\e[m    \e[$number (•6)\e[m \e[$below SOWDOWSOK\e[m"
echo -e "  \e[$number (•3)\e[m \e[$below VLESS gRPC & WS\e[m    \e[$number (•7)\e[m \e[$below WIREGUARD\e[m"  
echo -e "  \e[$number (•4)\e[m \e[$below TROJAN gRPC & WS\e[m   \e[$number (•8)\e[m \e[$below INSTALL UDP\e[m"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                        \e[30m[\e[$box VPS MENU\e[30m ]\e[1m                       \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$number (•9)\e[m \e[$below SYSTEM MENU\e[m          \e[$number (13)\e[m \e[$below MENU THEMES\e[m"
echo -e "  \e[$number (10)\e[m \e[$below CHECK RUNNING\e[m        \e[$number (14)\e[m \e[$below RENEW CERT\e[m"
echo -e "  \e[$number (11)\e[m \e[$below CHANGE PORT\e[m          \e[$number (15)\e[m \e[$below XRAY VERSION\e[m"
echo -e "  \e[$number (12)\e[m \e[$below REBOOT VPS\e[m           \e[$number (16)\e[m \e[$below CLEAR LOG VPS\e[m"
echo -e ""
echo -e "  \e[$below[Ctrl + C] For exit from main menu\e[m"
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$below Version Name         : SSHWS XRAY MULTIPORT Beta v0.9"
echo -e "  \e[$below Autoscript By        : JengkolOnline"
echo -e "  \e[$below Certificate Status   : Expired in $certifacate days"
echo -e "  \e[$below Client Name          : $username"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "\e[$below "
read -p " Select menu :  " menu
echo -e ""
case $menu in
1)
    ssh
    ;;
2)
    vmess
    ;;
3)
    vless
    ;;
4)
   trojan
    ;;
5)
   trojango
    ;;
6) 
   sowdowsok  
    ;;
7)
   menuwg
    ;;
8)
  wget --load-cookies /tmp/cookies.txt ${UDPCORE} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp
    ;;
9)
    system
    ;;
10)
    check-sc
    ;;
11)
    change-port
    ;;
12)
    reboot
    ;;
13)
    themes
    ;;
14)
    certv2ray
    ;;
15)
    xray version
    ;;
16)
    clear-log
    ;;

x)
    clear
    exit
    echo -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
    ;;
*)
    clear
    echo -e "\e[1;31mPlease enter an correct number\e[0m"
    sleep 1
    menu
    ;;
esac
