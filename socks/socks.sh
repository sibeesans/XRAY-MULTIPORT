#wget https://github.com/${GitUser}/
GitUser="Kulanbagong1"

# // IZIN SCRIPT
export MYIP=$(curl -sS ipv4.icanhazip.com)

# // Valid Script
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
sleep 0.1
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
clear
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
echo -e "${RB}————————————————————————————————————————————————————————${NC}"
echo -e "              ${GB}----- [ Socks5 Menu ] -----${NC}               "
echo -e "${RB}————————————————————————————————————————————————————————${NC}"
echo -e ""
echo -e " ${GB}[1]${NC} ${YB}Create Account Socks5${NC} "
echo -e " ${GB}[2]${NC} ${YB}Trial Account Socks5${NC} "
echo -e " ${GB}[3]${NC} ${YB}Extend Account Socks5${NC} "
echo -e " ${GB}[4]${NC} ${YB}Delete Account Socks5${NC} "
echo -e " ${GB}[5]${NC} ${YB}Check User Login${NC} "
echo -e ""
echo -e " ${GB}[0]${NC} ${YB}Back To Menu${NC}"
echo -e ""
echo -e "${RB}————————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-socks ; exit ;;
2) clear ; trialsocks ; exit ;;
3) clear ; extend-socks ; exit ;;
4) clear ; del-socks ; exit ;;
5) clear ; cek-socks ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "salah tekan " ; sleep 1 ; socks ;;
esac
