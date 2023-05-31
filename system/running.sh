export red="\e[1;31m"
export green="\e[0;32m"
export NC="\e[0m"

# // GIT USER
export GitUser="Kulanbagong1"
export MYIP=$(wget -qO- icanhazip.com);
#source /var/lib/premium-script/ipvps.conf
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
#Domain
#IP=$(wget -qO- icanhazip.com);
#source /var/lib/premium-script/ipvps.conf
#if [[ "$IP" = "" ]]; then
#domain=$(cat /usr/local/etc/xray/domain)"
#else
#domain=$IP
#fi
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

#Domain
#IP=$(wget -qO- icanhazip.com);
#source /var/lib/premium-script/ipvps.conf
#if [[ "$IP" = "" ]]; then
domain="$(cat /usr/local/etc/xray/domain)"
#else
#domain=$IP
#fi

echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Your VPS Information :"
echo -e "\e[0;32mSCRIPT VPS\e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Operating System Information :"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
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
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Hardware Information :"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Processor   : $tipeprosesor"
echo -e "Proc Core   : $totalcore"
echo -e "Virtual     : $typevps"
echo -e "Cpu Usage   : $cpu_usage"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "System Status / System Information :"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Uptime      : $uptime ( From VPS Booting )"
echo -e "Total RAM   : $tram MB"
echo -e "Used RAM    : $uram MB"
echo -e "Avaible RAM : $fram MB"
echo -e "Download    : $downloadsize GB ( From Startup/VPS Booting )"
echo -e "Upload      : $uploadsize GB ( From Startup/VPS Booting )"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Internet Service Provider Information :"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -e "Public IP   : $MYIP"
echo -e "Domain      : $Domen"
echo -e "ISP Name    : $NAMAISP"
echo -e "Region      : $REGION "
echo -e "Country     : $COUNTRY"
echo -e "City        : $CITY "
echo -e "Time Zone   : $WAKTUE"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Time & Date & Location & Coordinate Information :"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Location    : $COUNTRY"
echo -e "Coordinate  : $koordinat"
echo -e "Time Zone   : $WAKTUE"
echo -e "Date        : $harini"
echo -e "Time        : $jam ( WIB )"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "\e[1;32mSTATUS SCRIPT :\e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "\e[0;34mUser        :\e[0m $username"
echo -e "\e[0;34mOrder ID    :\e[0m $oid"
echo -e "\e[0;34mExpired     :\e[0m $exp"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e ""
echo -e "              \e[0;32m[\e[1;36mSYSTEM STATUS INFORMATION\e[0;32m]\e[0m"
echo -e "             \e[0;34m=============================\e[0m"
echo -e ""
echo -e "\e[1;33mSTATUS SSH & OPEN VPN:\e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
status="$(systemctl show ssh.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Open SSH                : "$green"running"$NC" ✓"
else
echo -e " Open SSH                : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show --now openvpn-server@server-tcp-1194 --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OpenVPN TCP             : "$green"running"$NC" ✓"
else
echo -e " OpenVPN TCP             : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show --now openvpn-server@server-udp-2200 --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OpenVPN UDP             : "$green"running"$NC" ✓"
else
echo -e " OpenVPN UDP             : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show stunnel4.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Stunnel(SSL)            : "$green"running"$NC" ✓"
else
echo -e " Stunnel(SSL)            : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show dropbear.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " DropBear                : "$green"running"$NC" ✓"
else
echo -e " DropBear                : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-http.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket SSH(HTTP)     : "$green"running"$NC" ✓"
else
echo -e " Websocket SSH(HTTP)     : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-https.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket SSL(HTTPS)    : "$green"running"$NC" ✓"
else
echo -e " Websocket SSL(HTTPS)    : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-ovpn.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket OpenVPN(HTTP) : "$green"running"$NC" ✓"
else
echo -e " Websocket OpenVPN(HTTP) : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohps.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-SSH                 : "$green"running"$NC" ✓"
else
echo -e " OHP-SSH                 : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohpd.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-Dropbear            : "$green"running"$NC" ✓"
else
echo -e " OHP-Dropbear            : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohp.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-OpenVPN             : "$green"running"$NC" ✓"
else
echo -e " OHP-OpenVPN             : "$red"not running (Error)"$NC" "
fi

echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "\e[1;33mSTATUS XRAY:\e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
status="$(systemctl show xray --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless tls          : "$green"running"$NC" ✓"
else
echo -e " Xray Vless tls          : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless None tls     : "$green"running"$NC" ✓"
else
echo -e " Xray Vless None tls     : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless gRPC         : "$green"running"$NC" ✓"
else
echo -e " Xray Vless gRPC         : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess Tls          : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess Tls          : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess None Tls     : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess None Tls     : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess gRPC         : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess gRPC         : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan Tls         : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan Tls         : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan None Tls    : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan None Tls    : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan gRPC        : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan gRPC        : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Sowdowsok Tls      : "$green"running"$NC" ✓"
else
echo -e " Xray Sowdowsok Tls      : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Sowdowsok No Tls   : "$green"running"$NC" ✓"
else
echo -e " Xray Sowdowsok No Tls   : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Sowdowsok gRPC      : "$green"running"$NC" ✓"
else
echo -e " Xray Sowdowsok gRPC      : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Sowdowsok2022       : "$green"running"$NC" ✓"
else
echo -e " Xray Sowdowsok2022       : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Sowdowsok5          : "$green"running"$NC" ✓"
else
echo -e " Xray Sowdowsok5          : "$red"not running (Error)"$NC" "
fi

echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "\e[1;33mSTATUS NGINX & SQUID:\e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
status="$(systemctl show nginx.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Nginx                   : "$green"running"$NC" ✓"
else
echo -e " Nginx                   : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show squid.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Squid                   : "$green"running"$NC" ✓"
else
echo -e " Squid                   : "$red"not running (Error)"$NC" "
fi

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e ""
echo -e "${green}JIKA TERDAPAT NOT RUNNING, PLEASE REPORT TO ADMIN FOR FIX$NC"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
