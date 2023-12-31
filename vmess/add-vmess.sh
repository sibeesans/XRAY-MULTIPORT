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
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
clear
#domain=$(cat /usr/local/etc/xray/domain)
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "${RB}————————————————————————————————————————————————————${NC}"
echo -e "                 ${GB}Add Vmess Account${NC}                  "
echo -e "${RB}————————————————————————————————————————————————————${NC}"
read -rp "User: " -e user
CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "${RB}————————————————————————————————————————————————————${NC}"
echo -e "                 ${GB}Add Vmess Account${NC}                  "
echo -e "${RB}————————————————————————————————————————————————————${NC}"
echo -e "${YB}A client with the specified name was already created, please choose another name.${NC}"
echo -e "${RB}————————————————————————————————————————————————————${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
add-vmess
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vmess-grpc$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
vlink1=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "443",
"id": "$uuid",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "$domain",
"tls": "tls"
}
EOF
vlink2=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "80",
"id": "$uuid",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "$domain",
"tls": "none"
}
EOF
vlink3=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "443",
"id": "$uuid",
"aid": "0",
"net": "grpc",
"path": "vmess-grpc",
"type": "none",
"host": "$domain",
"tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by Techslim
# Credit : Clash For Android

# CONFIG CLASH VMESS
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $user, server: ${sts}${domain}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-path: $patchnontls, ws-headers: {Host: $sni}}
proxy-groups:
  - name: ðŸš€ èŠ‚ç‚¹é€‰æ‹©
    type: select
    proxies:
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - DIRECT
      - $user
  - name: â™»ï¸ è‡ªåŠ¨é€‰æ‹©
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $user
  - name: ðŸŒ å›½å¤–åª’ä½“
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“² ç”µæŠ¥ä¿¡æ¯
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: â“‚ï¸ å¾®è½¯æœåŠ¡
    type: select
    proxies:
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - $user
  - name: ðŸŽ è‹¹æžœæœåŠ¡
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“¢ è°·æ­ŒFCM
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
  - name: ðŸŽ¯ å…¨çƒç›´è¿ž
    type: select
    proxies:
      - DIRECT
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
  - name: ðŸ›‘ å…¨çƒæ‹¦æˆª
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸƒ åº”ç”¨å‡€åŒ–
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸŸ æ¼ç½‘ä¹‹é±¼
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
END
# // masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# // Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml

vmesslink1="vmess://$(echo $vlink1 | base64 -w 0)"
vmesslink2="vmess://$(echo $vlink2 | base64 -w 0)"
vmesslink3="vmess://$(echo $vlink3 | base64 -w 0)"
cat > /var/www/html/vmess/vmess-$user.txt << END
==========================
Vmess WS (CDN) TLS
==========================
- name: Vmess-$user
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
   path: /vmess
   headers:
    Host: ${domain}
==========================
Vmess WS (CDN)
==========================
- name: Vmess-$user
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
   path: /vmess
   headers:
    Host: ${domain}
==========================
Vmess gRPC (CDN)
==========================
- name: Vmess-$user
  server: $domain
  port: 443
  type: vmess
  uuid: $uuid
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: $domain
  skip-cert-verify: true
   grpc-opts:
    grpc-service-name: "vmess-grpc"
==========================
Link Vmess Account
==========================
Link TLS  : vmess://$(echo $vlink1 | base64 -w 0)
==========================
Link NTLS : vmess://$(echo $vlink2 | base64 -w 0)
==========================
Link gRPC : vmess://$(echo $vlink3 | base64 -w 0)
==========================
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "                   Vmess Account                    " | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Remarks       : $user" | tee -a /user/log-vmess-$user.txt
echo -e "ISP           : $ISP" | tee -a /user/log-vmess-$user.txt
echo -e "City          : $CITY" | tee -a /user/log-vmess-$user.txt
echo -e "Domain        : $domain" | tee -a /user/log-vmess-$user.txt
echo -e "Wildcard      : (bug.com).$domain" | tee -a /user/log-vmess-$user.txt
echo -e "Port TLS      : 443" | tee -a /user/log-vmess-$user.txt
echo -e "Port NTLS     : 80" | tee -a /user/log-vmess-$user.txt
echo -e "Port gRPC     : 443" | tee -a /user/log-vmess-$user.txt
echo -e "Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-vmess-$user.txt
echo -e "Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-vmess-$user.txt
echo -e "id            : $uuid" | tee -a /user/log-vmess-$user.txt
echo -e "AlterId       : 0" | tee -a /user/log-vmess-$user.txt
echo -e "Security      : auto" | tee -a /user/log-vmess-$user.txt
echo -e "Network       : Websocket" | tee -a /user/log-vmess-$user.txt
echo -e "Path          : /(multipath) • ubah suka-suka" | tee -a /user/log-vmess-$user.txt
echo -e "ServiceName   : vmess-grpc" | tee -a /user/log-vmess-$user.txt
echo -e "Alpn          : h2, http/1.1" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Link TLS      : $vmesslink1" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Link NTLS     : $vmesslink2" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Link gRPC     : $vmesslink3" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Format Clash  : http://$domain:8000/vmess/vmess-$user.txt" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "Expired On    : $exp" | tee -a /user/log-vmess-$user.txt
echo -e "————————————————————————————————————————————————————${NC}" | tee -a /user/log-vmess-$user.txt
echo " " | tee -a /user/log-vmess-$user.txt
echo " " | tee -a /user/log-vmess-$user.txt
echo " " | tee -a /user/log-vmess-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
vmess
