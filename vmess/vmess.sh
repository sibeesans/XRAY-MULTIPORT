#wget https://github.com/${GitUser}/
GitUser="sibeesans"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/izinn/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
echo -e "\e[32mloading...\e[0m"
clear
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
clear
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text             \e[30m═[\e[$box MENU XRAY/VLESS\e[30m ]═          \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e ""
echo -e " ${GB}[1]${NC} ${YB}Create Account Vmess${NC} "
echo -e " ${GB}[2]${NC} ${YB}Trial Account Vmess${NC} "
echo -e " ${GB}[3]${NC} ${YB}Extend Account Vmess${NC} "
echo -e " ${GB}[4]${NC} ${YB}Delete Account Vmess${NC} "
echo -e " ${GB}[5]${NC} ${YB}Check User Login${NC} "
echo -e ""
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text \e[$box x)   MENU                             \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "\e[$line"
echo -e ""
read -p " Select menu :  "  sys
echo -e ""
case $sys in
1) clear  
   add-vmess 
   ;;
2) clear  t
   rialvmess  
   ;;
3) clear  
   extend-vmess  
   ;;
4) clear  
   del-vmess  
   ;;
5) clear  
   cek-vmess  
   ;;
0) clear  
   menu  
   ;;
x) exit 
;;
*) echo -e "salah tekan " ; sleep 1 ; vmess ;;
esac
