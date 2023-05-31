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
# xray config
cat > /usr/local/etc/xray/config.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
    },
   {
     "listen": "127.0.0.1",
     "port": "14016",
     "protocol": "vless",
      "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"                 
#vless
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vless"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "23456",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vmess"
          }
        }
     },
    {
      "listen": "127.0.0.1",
      "port": "25432",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",    
           "clients": [
              {
                 "password": "${uuid}"
#trojanws
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/trojan-ws"
            }
         }
     },
    {
         "listen": "127.0.0.1",
        "port": "30300",
        "protocol": "shadowsocks",
        "settings": {
           "clients": [
           {
           "method": "aes-128-gcm",
          "password": "${uuid}"
#ssws
           }
          ],
          "network": "tcp,udp"
       },
       "streamSettings":{
          "network": "ws",
             "wsSettings": {
               "path": "/ss-ws"
           }
        }
     },  
      {
        "listen": "127.0.0.1",
     "port": "24456",
        "protocol": "vless",
        "settings": {
         "decryption":"none",
           "clients": [
             {
               "id": "${uuid}"
#vlessgrpc
             }
          ]
       },
          "streamSettings":{
             "network": "grpc",
             "grpcSettings": {
                "serviceName": "vless-grpc"
           }
        }
     },
     {
      "listen": "127.0.0.1",
     "port": "31234",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessgrpc
             }
          ]
       },
       "streamSettings":{
         "network": "grpc",
            "grpcSettings": {
                "serviceName": "vmess-grpc"
          }
        }
     },
     {
        "listen": "127.0.0.1",
     "port": "33456",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
             "clients": [
               {
                 "password": "${uuid}"
#trojangrpc
               }
           ]
        },
         "streamSettings":{
         "network": "grpc",
           "grpcSettings": {
               "serviceName": "trojan-grpc"
         }
      }
   },
   {
    "listen": "127.0.0.1",
    "port": "30310",
    "protocol": "shadowsocks",
    "settings": {
        "clients": [
          {
             "method": "aes-128-gcm",
             "password": "${uuid}"
#ssgrpc
           }
         ],
           "network": "tcp,udp"
      },
    "streamSettings":{
     "network": "grpc",
        "grpcSettings": {
           "serviceName": "ss-grpc"
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
rm -rf /etc/systemd/system/xray.service.d
rm -rf /etc/systemd/system/xray@.service
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
cat > /etc/systemd/system/runn.service <<EOF
[Unit]
Description=Mantap-Sayang
After=network.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/mkdir -p /var/run/xray
ExecStart=/usr/bin/chown www-data:www-data /var/run/xray
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

#Install Trojan Go
latest_version="$(curl -s "https://api.github.com/repos/p4gefau1t/trojan-go/releases" | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
trojango_link="https://github.com/p4gefau1t/trojan-go/releases/download/v${latest_version}/trojan-go-linux-amd64.zip"
mkdir -p "/usr/bin/trojan-go"
mkdir -p "/etc/trojan-go"
cd `mktemp -d`
curl -sL "${trojango_link}" -o trojan-go.zip
unzip -q trojan-go.zip && rm -rf trojan-go.zip
mv trojan-go /usr/local/bin/trojan-go
chmod +x /usr/local/bin/trojan-go
mkdir /var/log/trojan-go/
touch /etc/trojan-go/akun.conf
touch /var/log/trojan-go/trojan-go.log

# Buat Config Trojan Go
cat > /etc/trojan-go/config.json << END
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 2087,
  "remote_addr": "127.0.0.1",
  "remote_port": 89,
  "log_level": 1,
  "log_file": "/var/log/trojan-go/trojan-go.log",
  "password": [
      "$uuid"
  ],
  "disable_http_check": true,
  "udp_timeout": 60,
  "ssl": {
    "verify": false,
    "verify_hostname": false,
    "cert": "/etc/xray/xray.crt",
    "key": "/etc/xray/xray.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "$domain",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 0,
    "fingerprint": "firefox"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": true
  },
  "mux": {
    "enabled": false,
    "concurrency": 8,
    "idle_timeout": 60
  },
  "websocket": {
    "enabled": true,
    "path": "/trojango",
    "host": "$domain"
  },
    "api": {
    "enabled": false,
    "api_addr": "",
    "api_port": 0,
    "ssl": {
      "enabled": false,
      "key": "",
      "cert": "",
      "verify_client": false,
      "client_cert": []
    }
  }
}
END
# Installing Trojan Go Service
cat > /etc/systemd/system/trojan-go.service << END
[Unit]
Description=Trojan-Go Service Mod By ADAM SIJA
Documentation=github.com/adammoi/vipies
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/trojan-go -config /etc/trojan-go/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# Trojan Go Uuid
cat > /etc/trojan-go/uuid.txt << END
$uuid
END

#xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/xray.conf

#sevice
echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart xray "
systemctl daemon-reload
systemctl enable xray.service
systemctl restart xray.service
systemctl enable xray
systemctl restart xray
systemctl stop trojan-go
systemctl start trojan-go
systemctl enable trojan-go
systemctl restart trojan-go

#dowload sc
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
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojango${NC}"
wget -O /usr/bin/trojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowshoks/trojango.sh"
wget -O /usr/bin/add-trojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/add-trojango.sh"
wget -O /usr/bin/del-trojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/del-trojango.sh"
wget -O /usr/bin/extend-trojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/extend-trojango.sh"
wget -O /usr/bin/trialtrojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/trialtrojango.sh"
wget -O /usr/bin/cek-trojango "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/shadowsocks/cek-trojango.sh"
#sleep 0.5
#echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -O /usr/bin/socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/socks.sh"
wget -O /usr/bin/add-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/add-socks.sh"
wget -O /usr/bin/del-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/del-socks.sh"
wget -O /usr/bin/extend-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/extend-socks.sh"
wget -O /usr/bin/trialsocks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/trialsocks.sh"
wget -O /usr/bin/cek-socks "https://raw.githubusercontent.com/${GitUser}/XRAY-MULTIPORT/main/socks/cek-socks.sh"
#sleep 0.5
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
chmod +x /usr/bin/add-trojango
chmod +x /usr/bin/del-trojango
chmod +x /usr/bin/extend-trojango
chmod +x /usr/bin/trialtrojango
chmod +x /usr/bin/cek-trojango
chmod +x /usr/bin/add-socks
chmod +x /usr/bin/del-socks
chmod +x /usr/bin/extend-socks
chmod +x /usr/bin/trialsocks
chmod +x /usr/bin/cek-socks
chmod +x /usr/bin/vmess
chmod +x /usr/bin/vless
chmod +x /usr/bin/trojan
chmod +x /usr/bin/trojango
chmod +x /usr/bin/socks
chmod +x /usr/bin/port-xray
chmod +x /usr/bin/certv2ray

cd
rm -f ins-xray.sh
mv /root/domain /usr/local/etc/xray/domain
cp /usr/local/etc/xray/domain /etc/xray/domain
sleep 1
clear
#aaaa
#aaaa
