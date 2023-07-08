#wget https://github.com/${GitUser}/
GitUser="sibeesans"

# // IZIN SCRIPT
export MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
    clear
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl -sS https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
sleep 0.1
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi

# // PROVIDED
clear
source /var/lib/premium-script/ipvps.conf
export creditt=$(cat /root/provided)

# // BANNER COLOUR
export banner_colour=$(cat /etc/banner)

# // TEXT ON BOX COLOUR
export box=$(cat /etc/box)

# // LINE COLOUR
export line=$(cat /etc/line)

# // TEXT COLOUR ON TOP
export text=$(cat /etc/text)

# // TEXT COLOUR BELOW
export below=$(cat /etc/below)

# // BACKGROUND TEXT COLOUR
export back_text=$(cat /etc/back)

# // NUMBER COLOUR
export number=$(cat /etc/number)

# // TOTAL ACC CREATE VMESS WS
#export total1=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")

# // TOTAL ACC CREATE  VLESS WS
#export total2=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")

# // TOTAL ACC CREATE  VLESS TCP XTLS
#export total3=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
if [[ "$IP" = "" ]]; then
     domain=$(cat /usr/local/etc/xray/domain)
else
     domain=$IP
clear
user=trial-`echo $RANDOM | head -c4`
cipher2="2022-blake3-aes-256-gcm"
userpsk=$(openssl rand -base64 32)
serverpsk=$(cat /usr/local/etc/xray/serverpsk)
masaaktif=1
echo ""
echo ""
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#shadowsocks2022$/a\#% '"$user $exp"'\
},{"password": "'""$userpsk""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#shadowsocks2022-grpc$/a\#% '"$user $exp"'\
},{"password": "'""$userpsk""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -n "$cipher2:$serverpsk:$userpsk" | base64 -w 0 > /tmp/log
ss2022_base64=$(cat /tmp/log)
ss2022link1="ss://${ss2022_base64}@$domain:443?path=/shadowsocks2022&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
ss2022link2="ss://${ss2022_base64}@$domain:80?path=/shadowsocks2022&security=none&host=${domain}&type=ws#${user}"
ss2022link3="ss://${ss2022_base64}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=shadowsocks2022-grpc&sni=$domain#${user}"
rm -rf /tmp/log
cat > /var/www/html/shadowsocks2022/shadowsocks2022-$user.txt << END
===============================
Shadowsocks 2022 WS (CDN) TLS
===============================
- name: SS2022-$user
type: ss
server: $domain
port: 443
cipher: $cipher2
password: $serverpsk:$userpsk
plugin: v2ray-plugin
plugin-opts:
mode: websocket
tls: true
skip-cert-verify: true
host: $domain
path: "/shadowsocks2022"
mux: true
=============================
Shadowsocks 2022 WS (CDN)
=============================
- name: SS2022-$user
type: ss
server: $domain
port: 80
cipher: $cipher2
password: $serverpsk:$userpsk
plugin: v2ray-plugin
plugin-opts:
mode: websocket
tls: false
skip-cert-verify: false
host: $domain
path: "/shadowsocks2022"
mux: true
===============================
Link Shadowsocks 2022 Account
===============================
Link TLS : ss://${ss2022_base64}@$domain:443?path=/shadowsocks2022&security=tls&host=${domain}&type=ws&sni=${domain}#${user}
==============================
Link NTLS : ss://${ss2022_base64}@$domain:80?path=/shadowsocks2022&security=none&host=${domain}&type=ws#${user}
==============================
Link gRPC : ss://${ss2022_base64}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=shadowsocks2022-grpc&sni=$domain#${user}
==============================
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "           Trial Shadowsocks 2022 Account           " | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Remarks       : ${user}" | tee -a /user/log-ss2022-$user.txt
echo -e "ISP           : ${ISP}" | tee -a /user/log-ss2022-$user.txt
echo -e "City          : ${CITY}" | tee -a /user/log-ss2022-$user.txt
echo -e "Domain        : ${domain}" | tee -a /user/log-ss2022-$user.txt
echo -e "Wildcard      : (bug.com).${domain}" | tee -a /user/log-ss2022-$user.txt
echo -e "Port TLS      : 443" | tee -a /user/log-ss2022-$user.txt
echo -e "Port NTLS     : 80" | tee -a /user/log-ss2022-$user.txt
echo -e "Port gRPC     : 443" | tee -a /user/log-ss2022-$user.txt
echo -e "Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-ss2022-$user.txt
echo -e "Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-ss2022-$user.txt
echo -e "Cipher        : ${cipher2}" | tee -a /user/log-ss2022-$user.txt
echo -e "Password      : $serverpsk:$userpsk" | tee -a /user/log-ss2022-$user.txt
echo -e "Network       : Websocket, gRPC" | tee -a /user/log-ss2022-$user.txt
echo -e "Path          : /shadowsocks2022" | tee -a /user/log-ss2022-$user.txt
echo -e "ServiceName   : shadowsocks2022-grpc" | tee -a /user/log-ss2022-$user.txt
echo -e "Alpn          : h2, http/1.1" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Link TLS      : ${ss2022link1}" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Link NTLS     : ${ss2022link2}" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Link gRPC     : ${ss2022link3}" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Format Clash  : http://$domain:8000/shadowsocks2022/shadowsocks2022-$user.txt" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Expired On    : $exp" | tee -a /user/log-ss2022-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo " " | tee -a /user/log-ss2022-$user.txt
echo " " | tee -a /user/log-ss2022-$user.txt
echo " " | tee -a /user/log-ss2022-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
shadowsocks2022
