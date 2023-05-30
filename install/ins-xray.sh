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
sleep 0.5;
clear;

# set uuid
uuid=$(cat /proc/sys/kernel/random/uuid)
# // JSON All
cat> /usr/local/etc/xray/config.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 10000,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
        },
      "tag": "api"
    },
    {
      "listen": "127.0.0.1",
      "port": "10001",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "286a4638-428e-41c7-9e2a-32ee25e8890a",
            "alterId": 0
#vmess
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10002",
      "protocol": "vless",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "id": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#vless
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/vless",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10003",
      "protocol": "trojan",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "password": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#trojan
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/trojan",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10004",
      "protocol": "shadowsocks",
      "settings": {
        "clients": [
            {
              "method": "aes-256-gcm",
              "password": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#shadowsocks
            }
          ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/shadowsocks",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10005",
      "protocol": "shadowsocks",
      "settings": {
        "method": "2022-blake3-aes-256-gcm",
        "password": "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=",
        "clients": [
          {
            "password": "gv5gp9oyQmPB4mWnq+6LICXYfnFHyRUbCfcPIHb+PQY="
#shadowsocks2022
          }
        ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/shadowsocks2022",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10006",
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
            {
              "user": "private",
              "pass": "server"
#socks
            }
          ],
        "udp": true,
        "ip": "127.0.0.1"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/socks5",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20001",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "286a4638-428e-41c7-9e2a-32ee25e8890a",
            "alterId": 0
#vmess-grpc
          }
        ]
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "vmess-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20002",
      "protocol": "vless",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "id": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#vless-grpc
          }
        ]
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "vless-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20003",
      "protocol": "trojan",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "password": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#trojan-grpc
          }
        ],
        "udp": true
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "trojan-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20004",
      "protocol": "shadowsocks",
      "settings": {
        "clients": [
            {
              "method": "aes-256-gcm",
              "password": "286a4638-428e-41c7-9e2a-32ee25e8890a"
#shadowsocks-grpc
            }
          ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "shadowsocks-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20005",
      "protocol": "shadowsocks",
      "settings": {
        "method": "2022-blake3-aes-256-gcm",
        "password": "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=",
        "clients": [
          {
            "password": "gv5gp9oyQmPB4mWnq+6LICXYfnFHyRUbCfcPIHb+PQY="
#shadowsocks2022-grpc
          }
        ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "shadowsocks2022-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20006",
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
            {
              "user": "private",
              "pass": "server"
#socks-grpc
            }
          ],
        "udp": true,
        "ip": "127.0.0.1"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "socks5-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
 END     

# // IPTABLE TCP 
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10000 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10001 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10002 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10003 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10004 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10005 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10006 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20001 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20002 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20003 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20004 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20005 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 20006 -j ACCEPT


# // IPTABLE UDP
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10000 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10001 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10002 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10003 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10004 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10005 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10006 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20001 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20002 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20003 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20004 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20005 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 20006 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# // ENABLE XRAY TCP XTLS 80/443
systemctl daemon-reload
systemctl enable xray.service
systemctl restart xray.service

# download script
cd /usr/bin
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vmess${NC}"
wget -q -O vmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/vmess.sh"
wget -q -O add-vmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/add-vmess.sh"
wget -q -O del-vmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/del-vmess.sh"
wget -q -O extend-vmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/extend-vmess.sh"
wget -q -O trialvmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/trialvmess.sh"
wget -q -O cek-vmess "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vmess/cek-vmess.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vless${NC}"
wget -q -O vless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/vless.sh"
wget -q -O add-vless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/add-vless.sh"
wget -q -O del-vless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/del-vless.sh"
wget -q -O extend-vless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/extend-vless.sh"
wget -q -O trialvless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/trialvless.sh"
wget -q -O cek-vless "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/vless/cek-vless.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojan${NC}"
wget -q -O trojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/trojan.sh"
wget -q -O add-trojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/add-trojan.sh"
wget -q -O del-trojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/del-trojan.sh"
wget -q -O extend-trojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/extend-trojan.sh"
wget -q -O trialtrojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/trialtrojan.sh"
wget -q -O cek-trojan "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/trojan/cek-trojan.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks${NC}"
wget -q -O shadowsocks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowshoks/shadowsocks.sh"
wget -q -O add-ss "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks/add-ss.sh"
wget -q -O del-ss "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks/del-ss.sh"
wget -q -O extend-ss "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks/extend-ss.sh"
wget -q -O trialss "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks/trialss.sh"
wget -q -O cek-ss "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks/cek-ss.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks 2022${NC}"
wget -q -O shadowsocks2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/shadowsocks2022.sh"
wget -q -O add-ss2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/add-ss2022.sh"
wget -q -O del-ss2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/del-ss2022.sh"
wget -q -O extend-ss2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/extend-ss2022.sh"
wget -q -O trialss2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/trialss2022.sh"
wget -q -O cek-ss2022 "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/shadowsocks2022/cek-ss2022.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -q -O socks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/socks.sh"
wget -q -O add-socks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/add-socks.sh"
wget -q -O del-socks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/del-socks.sh"
wget -q -O extend-socks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/extend-socks.sh"
wget -q -O trialsocks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/trialsocks.sh"
wget -q -O cek-socks "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/socks/cek-socks.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu All Xray${NC}"
wget -q -O allxray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/allxray.sh"
wget -q -O add-xray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/add-xray.sh"
wget -q -O del-xray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/del-xray.sh"
wget -q -O extend-xray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/extend-xray.sh"
wget -q -O trialxray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/trialxray.sh"
wget -q -O cek-xray "https://raw.githubusercontent.com/Kulanbagong1/XRAY-MULTIPORT/main/allxray/cek-xray.sh"
sleep 0.5
#Prot
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/change-port/port-xray.sh"
wget -O certv2ray "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/cert.sh"

#chmod
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
chmod +x shadowsocks
chmod +x shadowsocks2022
chmod +x socks
chmod +x allxray
chmod +x port-xray
chmod +x certv2ray

cd
rm -f ins-xray.sh
mv /root/domain /usr/local/etc/xray/domain
cp /usr/local/etc/xray/domain /etc/xray/domain
sleep 1
clear;
