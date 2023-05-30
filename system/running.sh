export red="\e[1;31m"
export green="\e[0;32m"
export NC="\e[0m"

# // GIT USER
export GitUser="Kulanbagong1"
export MYIP=$(wget -qO- icanhazip.com);

# // VPS INFO
clear
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
    lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
    lan_net="eth0"
    typevps="KVM"
    sleep 1
fi

# // VPS ISP INFORMATION
echo -e "\e[32mloading...\e[0m"
clear
export ITAM='\033[0;30m'
echo -e "$ITAM"
export NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
export REGION=$( curl -s ipinfo.io/region )
export COUNTRY=$( curl -s ipinfo.io/country )
export WAKTU=$( curl -s ipinfo.ip/timezone )
export CITY=$( curl -s ipinfo.io/city )
export REGION=$( curl -s ipinfo.io/region )
export WAKTUE=$( curl -s ipinfo.io/timezone )
export koordinat=$( curl -s ipinfo.io/loc )

# // TOTAL RAM
export tram=$( free -m | awk 'NR==2 {print $2}' )
export uram=$( free -m | awk 'NR==2 {print $3}' )
export fram=$( free -m | awk 'NR==2 {print $4}' )
export swap=$( free -m | awk 'NR==4 {print $2}' )

# // USERNAME
echo -e "$NC"
rm -f /usr/bin/user
export username=$( curl -sS https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# // ORDER ID
rm -f /usr/bin/ver
export user=$( curl -sS https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver

# // VALIDITY
rm -f /usr/bin/e
export valid=$( curl -sS https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e

# // DETAIL ORDER
export username=$(cat /usr/bin/user)
export oid=$(cat /usr/bin/ver)
export exp=$(cat /usr/bin/e)

# // TYPE PROCS
export totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
export totalcore+=" Core"
export corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
export tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# // SHELL VER
export shellversion=""
export shellversion=Bash
export shellversion+=" Version" 
export shellversion+=" ${BASH_VERSION/-*}" 
export versibash=$shellversion

# // OS INFO
source /etc/os-release
export Versi_OS=$VERSION
export ver=$VERSION_ID
export Tipe=$NAME
export URL_SUPPORT=$HOME_URL
export basedong=$ID

# // DOWNLOAD
export download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
export downloadsize=$(($download/1073741824))

# // UPLOAD
export upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
export uploadsize=$(($upload/1073741824))

# // CPU INFO
export cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
export cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
export cpu_usage+=" %"

# // OS UPTIME
export uptime="$(uptime -p | cut -d " " -f 2-10)"

# // KERNEL
export kernelku=$(uname -r)

# // DATE
export harini=`date -d "0 days" +"%d-%m-%Y"`
export jam=`date -d "0 days" +"%X"`

# // DNS PATH
export tipeos2=$(uname -m)

# // DOMAIN
export Domen="$(cat /usr/local/etc/xray/domain)"

# CHEK STATUS 
oovpn2=$(systemctl show --now openvpn-server@server-udp-2200 --no-page | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
oovpn=$(systemctl show --now openvpn-server@server-tcp-1194 --no-page | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"
#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)
#sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#ssh_status=$(systemctl status shadowsocks-libev-server@http | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status="$(systemctl status shadowsocks-libev.service --no-page)"
#status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
#tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#vless_tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#vless_nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#trojan_server=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#trojangfw_server=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginix_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(systemctl status squid.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(systemctl status ssh.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp_service=$(systemctl status ohps.service  | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp2_service=$(systemctl status ohps.service  | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp3_service=$(systemctl status ohps.service  | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(systemctl status ws-http.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
openvpn3_service=$(systemctl status ws-ovpn.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
websocketssl_service=$(systemctl status ws-http.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wg="$(systemctl show wg-quick@wg0.service --no-page)"
#swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
#trgo="$(systemctl show trojan-go.service --no-page)"                                      
#strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  
sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wstls=$(systemctl status ws-stunnel.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsdrop=$(systemctl status ws-dropbear.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsopen=$(systemctl status ws-openssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE OPENVPN TCP
if [[ $oovpn == "active" ]]; then
  status_openvpn=" ${GREEN}Running ${NC}( No Error )"
else
  status_openvpn="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE nginix
if [[ $nginix_service == "active" ]]; then
  status_nginix=" ${GREEN}Running ${NC}( No Error )"
else
  status_nginix="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE OPENVPN UDP
if [[ $oovpn2 == "active" ]]; then
  status_openvpn2=" ${GREEN}Running ${NC}( No Error )"
else
  status_openvpn2="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  OHP 
if [[ $ohp_service == "running" ]]; then 
   status_ohp=" ${GREEN}Running ${NC}( No Error )"
else
   status_ohp="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  OHP2 
if [[ $ohp2_service == "running" ]]; then 
   status_ohp2=" ${GREEN}Running ${NC}( No Error )"
else
   status_ohp2="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  OHP3 
if [[ $ohp3_service == "running" ]]; then 
   status_ohp2=" ${GREEN}Running ${NC}( No Error )"
else
   status_ohp2="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  websocket ssh 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  websocket openvpn 
if [[ $openvpn3_service == "running" ]]; then 
   status_openvpn3=" ${GREEN}Running ${NC}( No Error )"
else
   status_openvpn3="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  ssl 
if [[ $websocketssl_service == "running" ]]; then 
   websocket_ssl=" ${GREEN}Running ${NC}( No Error )"
else
   websocket_ssl="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  TLS 
if [[ $xray_service == "running" ]]; then 
   xray_status=" ${GREEN}Running${NC} ( No Error )"
else
   xray_status="${RED}  Not Running${NC}   ( Error )"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $sswg == "running" ]]; then 
   status_wg=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_wg="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTPS
#if [[ $vless_tls_v2ray_status == "running" ]]; then
#  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
#else
#  status_tls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi

# STATUS SERVICE VLESS HTTP
#if [[ $vless_nontls_v2ray_status == "running" ]]; then
#  status_nontls_vless=" ${GREEN}Running${NC} ( No Error )"
#else
#  status_nontls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
# STATUS SERVICE TROJAN
#if [[ $trojan_server == "running" ]]; then 
#   status_virus_trojan=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#   status_virus_trojan="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
# Status Service Trojan GO
#if [[ $strgo == "active" ]]; then
#  status_trgo=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#  status_trgo="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
# STATUS SERVICE TROJAN GFW
#if [[ $trojangfw_server == "running" ]]; then 
#   status_virus_trojangfw=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
 #  status_virus_trojangfw="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
# STATUS SERVICE DROPBEAR
#if [[ $dropbear_status == "running" ]]; then 
#   status_beruangjatuh=" ${GREEN}Running${NC} ( No Error )${NC}"
#else
#   status_beruangjatuh="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi

# STATUS SERVICE STUNNEL
#if [[ $stunnel_service == "running" ]]; then 
#   status_stunnel=" ${GREEN}Running ${NC}( No Error )"
#else
 #  status_stunnel="${RED}  Not Running ${NC}  ( Error )}"
#fi
# STATUS SERVICE WEBSOCKET TLS
#if [[ $wstls == "running" ]]; then 
#   swstls=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#   swstls="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi

# STATUS SERVICE WEBSOCKET DROPBEAR
#if [[ $wsdrop == "running" ]]; then 
 #  swsdrop=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#   swsdrop="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi

echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Your VPS Information :"
echo -e "\e[0;32mSCRIPT VPS\e[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Operating System Information :"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "VPS Type    : $typevps"
echo -e "OS Arch     : $tipeos2"
echo -e "Hostname    : $HOSTNAME"
echo -e "OS Name     : $Tipe"
echo -e "OS Version  : $Versi_OS"
echo -e "OS URL      : $URL_SUPPORT"
echo -e "OS BASE     : $basedong"
echo -e "OS TYPE     : Linux / Unix"
echo -e "Bash Ver    : $versibash"
echo -e "Kernel Ver  : $kernelku"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Hardware Information :"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Processor   : $tipeprosesor"
echo -e "Proc Core   : $totalcore"
echo -e "Virtual     : $typevps"
echo -e "Cpu Usage   : $cpu_usage"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "System Status / System Information :"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Uptime      : $uptime ( From VPS Booting )"
echo -e "Total RAM   : $tram MB"
echo -e "Used RAM    : $uram MB"
echo -e "Avaible RAM : $fram MB"
echo -e "Download    : $downloadsize GB ( From Startup/VPS Booting )"
echo -e "Upload      : $uploadsize GB ( From Startup/VPS Booting )"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Internet Service Provider Information :"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Public IP   : $MYIP"
echo -e "Domain      : $Domen"
echo -e "ISP Name    : $NAMAISP"
echo -e "Region      : $REGION "
echo -e "Country     : $COUNTRY"
echo -e "City        : $CITY "
echo -e "Time Zone   : $WAKTUE"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Time & Date & Location & Coordinate Information :"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Location    : $COUNTRY"
echo -e "Coordinate  : $koordinat"
echo -e "Time Zone   : $WAKTUE"
echo -e "Date        : $harini"
echo -e "Time        : $jam ( WIB )"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\e[1;32mSTATUS SCRIPT :\e[0m"
echo -e "\e[0;34mUser        :\e[0m $username"
echo -e "\e[0;34mOrder ID    :\e[0m $oid"
echo -e "\e[0;34mExpired     :\e[0m $exp"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m            ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ Open SSH                :$status_ssh"
echo -e "❇️ OpenVPN TCP             :$status_openvpn"
echo -e "❇️ OpenVPN UDP             :$status_openvpn2"
echo -e "❇️ Dropbear                :$status_beruangjatuh"
echo -e "❇️ Stunnel5                :$status_stunnel"
echo -e "❇️ Squid                   :$status_squid"
echo -e "❇️ Nginix                  :$status_nginix"
echo -e "❇️ Websocket SSL(HTTPS)    :$websocket_ssl"
echo -e "❇️ Websocket SSH(HTTP)     :$status_ssh"
echo -e "❇️ Websocket OpenVPN(HTTP) :$status_openvpn3"
echo -e "❇️ OHP-SSH                 :$status_ohp"
echo -e "❇️ OHP-Dropbear            :$status_ohp2"
echo -e "❇️ OHP-OpenVPN             :$status_ohp3"
echo -e "❇️ XRAYS Vmess TLS         :$xray_status"
echo -e "❇️ XRAYS Vmess GRPC        :$xray_status"
echo -e "❇️ XRAYS Vmess None TLS    :$xray_status"
echo -e "❇️ XRAYS Vless TLS         :$xray_status"
echo -e "❇️ XRAYS Vless GRPC        :$xray_status"
echo -e "❇️ XRAYS Vless None TLS    :$xray_status"
echo -e "❇️ XRAYS Trojan TLS        :$xray_status"
echo -e "❇️ XRAYS Trojan None TLS   :$xray_status"
echo -e "❇️ XRAYS Trojan GRPC       :$xray_status"
echo -e "❇️ Sowdowsok TLS           :$xray_status"
echo -e "❇️ Sowdowsok None TLS      :$xray_status"
echo -e "❇️ Sowdowsok GRPC          :$xray_status"
echo -e "❇️ Sowdowsok 2022          :$xray_status"
echo -e "❇️ Sowdowsok5              :$xray_status"
echo -e "❇️ Wireguard               :$status_wg"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
