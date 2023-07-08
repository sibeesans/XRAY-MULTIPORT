#wget https://github.com/${GitUser}/
GitUser="sibeesans"

# // IZIN SCRIPT
export MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
    clear
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl -sS https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
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
pass=`echo $RANDOM | head -c4`
masaaktif=1
echo ""
echo ""
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#socks$/a\#÷ '"$user $exp"'\
},{"user": "'""$user""'","pass": "'""$pass""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#socks-grpc$/a\#÷ '"$user $exp"'\
},{"user": "'""$user""'","pass": "'""$pass""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -n "$user:$pass" | base64 > /tmp/log
socks_base64=$(cat /tmp/log)
sockslink1="socks://$socks_base64@$domain:443?path=/socks5&security=tls&host=$domain&type=ws&sni=$domain#$user"
sockslink2="socks://$socks_base64@$domain:80?path=/socks5&security=none&host=$domain&type=ws#$user"
sockslink3="socks://$socks_base64@$domain:443?security=tls&encryption=none&type=grpc&serviceName=socks5-grpc&sni=$domain#$user"
rm -rf /tmp/log
cat > /var/www/html/socks5/socks5-$user.txt << EOF
========================
Format Json Socks5
========================
{
"inbounds": [],
"outbounds": [
{
"mux": {
"enabled": true
},
"protocol": "socks",
"settings": {
"servers": [
{
"address": "$domain",
"port": 443,
"users": [
{
"level": 8,
"pass": "$pass",
"user": "$user"
}
]
}
]
},
"streamSettings": {
"network": "ws",
"security": "tls",
"tlsSettings": {
"allowInsecure": true,
"serverName": "$domain"
},
"wsSettings": {
"headers": {
"Host": "$domain"
},
"path": "/socks5"
}
},
"tag": "XRAY"
}
],
"policy": {
"levels": {
"8": {
"connIdle": 300,
"downlinkOnly": 1,
"handshake": 4,
"uplinkOnly": 1
}
}
}
}
===============================
Link Socks5 Account
===============================
Link TLS : socks://$socks_base64@$domain:443?path=/socks5&security=tls&host=$domain&type=ws&sni=$domain#$user
==============================
Link NTLS : socks://$socks_base64@$domain:80?path=/socks5&security=none&host=$domain&type=ws#$user
==============================
Link gRPC : socks://$socks_base64@$domain:443?security=tls&encryption=none&type=grpc&serviceName=socks5-grpc&sni=$domain#$user
==============================
EOF
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "               Trial Socks5 Account                 " | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "Username      : ${user}" | tee -a /user/log-socks5-$user.txt
echo -e "Password      : ${pass}" | tee -a /user/log-socks5-$user.txt
echo -e "Domain        : ${domain}" | tee -a /user/log-socks5-$user.txt
echo -e "ISP           : ${ISP}" | tee -a /user/log-socks5-$user.txt
echo -e "City          : ${CITY}" | tee -a /user/log-socks5-$user.txt
echo -e "Wildcard      : (bug.com).${domain}" | tee -a /user/log-socks5-$user.txt
echo -e "Port TLS      : 443" | tee -a /user/log-socks5-$user.txt
echo -e "Port NTLS     : 80" | tee -a /user/log-socks5-$user.txt
echo -e "Port gRPC     : 443" | tee -a /user/log-socks5-$user.txt
echo -e "Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-socks5-$user.txt
echo -e "Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-socks5-$user.txt
echo -e "Network       : Websocket, gRPC" | tee -a /user/log-socks5-$user.txt
echo -e "Path          : /socks5" | tee -a /user/log-socks5-$user.txt
echo -e "ServiceName   : socks5-grpc" | tee -a /user/log-socks5-$user.txt
echo -e "Alpn          : h2, http/1.1" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "Link TLS      : ${sockslink1}" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "Link NTLS     : ${sockslink2}" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "Link gRPC     : ${sockslink3}" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo -e "Format JSON   : http://$domain:8000/socks5/socks5-$user.txt" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-ss2022-$user.txt
echo -e "Expired On    : $exp" | tee -a /user/log-socks5-$user.txt
echo -e "————————————————————————————————————————————————————" | tee -a /user/log-socks5-$user.txt
echo " " | tee -a /user/log-socks5-$user.txt
echo " " | tee -a /user/log-socks5-$user.txt
echo " " | tee -a /user/log-socks5-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
socks
