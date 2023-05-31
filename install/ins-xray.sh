#!/bin/bash
# // wget https://github.com/${GitUser}/
GitUser="Kulanbagong1"

# // MY IPVPS
export MYIP=$(curl -sS ipv4.icanhazip.com)

# // GETTING
VALIDITY () {
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
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
clear

# // install socat
apt install socat

# // EMAIL & DOMAIN
export emailcf=$(cat /usr/local/etc/xray/email)
export domain=$(cat /root/domain)

apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date

# // MAKE FILE TROJAN TCP
mkdir -p /etc/xray
mkdir -p /usr/local/etc/xray/
mkdir -p /var/log/xray/;
touch /usr/local/etc/xray/akunxtr.conf
touch /var/log/xray/access.log;
touch /var/log/xray/error.log;

# // VERSION XRAY
export version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

# // INSTALL CORE XRAY
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version ${version}

systemctl stop nginx

# // INSTALL CERTIFICATES
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain -d sshws.$domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain -d sshws.$domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
chmod 755 /usr/local/etc/xray/xray.key;
service squid start
systemctl restart nginx
sleep 0.5
clear

echo -e "${GB}[ INFO ]${NC} ${YB}Setup Nginx & Xray Conf${NC}"
echo "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=" > /usr/local/etc/xray/serverpsk
wget -q -O /usr/local/etc/xray/config.json https://raw.githubusercontent.com/${GitUser}/xraylite2/main/config.json
#wget -q -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/sreyaeve/xraylite2/main/nginx.conf
wget -q -O /etc/nginx/conf.d/xray.conf https://raw.githubusercontent.com/${GitUser}/xraylite2/main/xray.conf
#systemctl restart nginx
systemctl restart xray.service
systemctl restart xray
echo -e "${GB}[ INFO ]${NC} ${YB}Setup Done${NC}"
sleep 2
clear
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
#cd /usr/bin/
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vmess${NC}"
wget -O /usr/bin/vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/vmess.sh"
wget -O /usr/bin/add-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/add-vmess.sh"
wget -O /usr/bin/del-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/del-vmess.sh"
wget -O /usr/bin/extend-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/extend-vmess.sh"
wget -O /usr/bin/trialvmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/trialvmess.sh"
wget -O /usr/bin/cek-vmess "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vmess/cek-vmess.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vless${NC}"
wget -O /usr/bin/vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/vless.sh"
wget -O /usr/bin/add-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/add-vless.sh"
wget -O /usr/bin/del-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/del-vless.sh"
wget -O /usr/bin/extend-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/extend-vless.sh"
wget -O /usr/bin/trialvless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/trialvless.sh"
wget -O /usr/bin/cek-vless "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/vless/cek-vless.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojan${NC}"
wget -O /usr/bin/trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/trojan.sh"
wget -O /usr/bin/add-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/add-trojan.sh"
wget -O /usr/bin/del-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/del-trojan.sh"
wget -O /usr/bin/extend-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/extend-trojan.sh"
wget -O /usr/bin/trialtrojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/trialtrojan.sh"
wget -O /usr/bin/cek-trojan "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/trojan/cek-trojan.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks${NC}"
wget -O /usr/bin/sowdowsok "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowshoks/sowdowsok.sh"
wget -O /usr/binadd-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/add-ss.sh"
wget -O /usr/bindel-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/del-ss.sh"
wget -O /usr/bin/extend-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/extend-ss.sh"
wget -O /usr/bin/trialss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/trialss.sh"
wget -O /usr/bin/cek-ss "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/cek-ss.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks 2022${NC}"
wget -O /usr/bin/shadowsocks2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/shadowsocks2022.sh"
wget -O /usr/bin/add-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/add-ss2022.sh"
wget -O /usr/bin/del-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/del-ss2022.sh"
wget -O /usr/bin/extend-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/extend-ss2022.sh"
wget -O /usr/bin/trialss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/trialss2022.sh"
wget -O /usr/bin/cek-ss2022 "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks2022/cek-ss2022.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -O /usr/bin/socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/socks.sh"
wget -O /usr/bin/add-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/add-socks.sh"
wget -O /usr/bin/del-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/del-socks.sh"
wget -O /usr/bin/extend-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/extend-socks.sh"
wget -O /usr/bin/trialsocks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/trialsocks.sh"
wget -O /usr/bin/cek-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/cek-socks.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu All Xray${NC}"
wget -O /usr/bin/allxray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/allxray.sh"
wget -O /usr/bin/add-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/add-xray.sh"
wget -O /usr/bin/del-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/del-xray.sh"
wget -O /usr/bin/extend-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/extend-xray.sh"
wget -O /usr/bin/trialxray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/trialxray.sh"
wget -O /usr/bin/cek-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/allxray/cek-xray.sh"
#sleep 0.5
#Prot
wget -O /usr/bin/port-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/change-port/port-xray.sh"
wget -O /usr/bin/certv2ray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/cert.sh"

#chmod
chmod +x /usr/bin/add-vmess
chmod +x /usr/bin/del-vmess
chmod +x /usr/bin/extend-vmess
chmod +x /usr/bin/trialvmess
chmod +x /usr/bin/cek-vmess
chmod +x /usr/bin/add-vless
chmod +x /usr/bin/del-vless
chmod +x /usr/bin/extend-vless
chmod +x /usr/bin/trialvless
chmod +x /usr/bin/cek-vless
chmod +x /usr/bin/add-trojan
chmod +x /usr/bin/del-trojan
chmod +x /usr/bin/extend-trojan
chmod +x /usr/bin/trialtrojan
chmod +x /usr/bin/cek-trojan
chmod +x /usr/bin/add-ss
chmod +x /usr/bin/del-ss
chmod +x /usr/bin/extend-ss
chmod +x /usr/bin/trialss
chmod +x /usr/bin/cek-ss
chmod +x /usr/bin/add-ss2022
chmod +x /usr/bin/del-ss2022
chmod +x /usr/bin/extend-ss2022
chmod +x /usr/bin/trialss2022
chmod +x /usr/bin/cek-ss2022
chmod +x /usr/bin/add-socks
chmod +x /usr/bin/del-socks
chmod +x /usr/bin/extend-socks
chmod +x /usr/bin/trialsocks
chmod +x /usr/bin/cek-socks
chmod +x /usr/bin/add-xray
chmod +x /usr/bin/del-xray
chmod +x /usr/bin/extend-xray
chmod +x /usr/bin/trialxray
chmod +x /usr/bin/cek-xray
chmod +x /usr/bin/vmess
chmod +x /usr/bin/vless
chmod +x /usr/bin/trojan
chmod +x /usr/bin/sowdowsok
chmod +x /usr/bin/shadowsocks2022
chmod +x /usr/bin/socks
chmod +x /usr/bin/allxray
chmod +x /usr/bin/port-xray
chmod +x /usr/bin/certv2ray

cd
rm -f ins-xray.sh
mv /root/domain /usr/local/etc/xray/domain
cp /usr/local/etc/xray/domain /etc/xray/domain
sleep 1
clear
