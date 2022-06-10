#!/bin/bash
clear
[[ $(awk -F" " '{print $2}' /usr/lib/telegram) != "@nandoslayer" ]] && exit 0
msg() {
  BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
  AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
  case $1 in
  -ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -bra) cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -nazu) cor="${COLOR[6]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -gri) cor="\e[5m\033[1;100m" && echo -ne "${cor}${2}${SEMCOR}" ;;
  "-bar2" | "-bar") cor="${VERMELHO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}" ;;
  esac
}
fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${comando[0]} -y >/dev/null 2>&1
        ${comando[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "\033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "\033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
print_center() {
  if [[ -z $2 ]]; then
    text="$1"
  else
    col="$1"
    text="$2"
  fi

  while read line; do
    unset space
    x=$(((54 - ${#line}) / 2))
    for ((i = 0; i < $x; i++)); do
      space+=' '
    done
    space+="$line"
    if [[ -z $2 ]]; then
      msg -azu "$space"
    else
      msg "$col" "$space"
    fi
  done <<<$(echo -e "$text")
}
time_reboot() {
    echo ""
  print_center -ama "REINICIANDO EM "
  echo ""
  REBOOT_TIMEOUT="$1"

  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  reboot
}
fun_att_api () {
  echo ""
  echo -e "\033[1;31mAGUARDE \033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
  sleep 3
  clear
  if ps x | grep "bot_painel"|grep -v grep 1>/dev/null 2>/dev/null; then
    pidbot_painel=$(ps x|grep "bot_painel"|awk -F "pts" {'print $1'})
    kill -9 $pidbot_painel 1>/dev/null 2>/dev/null
    screen -wipe 1>/dev/null 2>/dev/null
    sleep 2
    wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/apibot -O /bin/ppweb/apibot > /dev/null 2>&1
    wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/bot -O /bin/ppweb/bot > /dev/null 2>&1
	chmod 777 -R /bin/ppweb > /dev/null 2>&1
  fi
  cd $HOME || exit
  echo ""
  echo -e "\033[1;36mBOT ATUALIZADO COM SUCESSO!\033[1;37m"
  sleep 3
  time_reboot "10"
}
fun_botOnOff() {
    [[ $(ps x | grep "bot_painel" | grep -v grep | wc -l) = '0' ]] && {
       clear
	   echo ""
       echo -e "\E[44;1;37m              INSTALADOR BOT PWEB                 \E[0m\n"
	   echo -e "                \033[1;33m[\033[1;31m!\033[1;33m] \033[1;31mATENÇÃO \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
	   echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
       echo -e "\n\033[1;32m1° \033[1;37m- \033[1;33mPELO SEU TELEGRAM ACESSE OS SEGUINTES BOT\033[1;37m:\033[0m"
       echo -e "\n\033[1;32m2° \033[1;37m- \033[1;33mBOT \033[1;37m@BotFather \033[1;33mCRIE O SEU BOT \033[1;31mOPÇÃO: \033[1;37m/newbot\033[0m"
       echo -e "\n\033[1;32m3° \033[1;37m- \033[1;33mBOT \033[1;37m@userinfobot \033[1;33mE PEGUE SEU ID \033[1;31mOPÇÃO: \033[1;37m/id\033[0m"
       echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
       echo ""
        echo -ne "\033[1;32mINFORME SEU TOKEN:\033[1;37m "
        read tokenbot
        echo ""
        echo -ne "\033[1;32mINFORME SEU ID:\033[1;37m "
        read iduser
        clear
        echo -e "\033[1;32mINICIANDO BOT PWEB \033[0m\n"
        fun_bot1() {
            [[ ! -e "/bin/ppweb/apibot" ]] && {
				wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/apibot -O /bin/ppweb/apibot > /dev/null 2>&1
        wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/bot -O /bin/ppweb/bot > /dev/null 2>&1
				chmod 777 -R /bin/ppweb > /dev/null 2>&1
			}
          cd /bin/ppweb
            screen -dmS bot_painel ./bot $tokenbot $iduser >/dev/null 2>&1
            [[ $(grep -wc "bot_painel" /etc/autostart) = '0' ]] && {
                echo -e "ps x | grep 'bot_painel' | grep -v 'grep' || cd /bin/ppweb && screen -dmS bot_painel ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
            } || {
                sed -i '/bot_painel/d' /etc/autostart
                echo -e "ps x | grep 'bot_painel' | grep -v 'grep' || cd /bin/ppweb && screen -dmS bot_painel ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
            }
            cd $HOME || exit
        }
        fun_bar 'fun_bot1'
        [[ $(ps x | grep "bot_painel" | grep -v grep | wc -l) != '0' ]] && echo -e "\n\033[1;32m BOT PWEB ATIVADO!\033[0m" || echo -e "\n\033[1;31m ERRO! CONFIRA SUAS INFORMAÇÕES\033[0m"
        sleep 2
        /bin/ppweb/botpweb.sh
    } || {
        clear
        echo -e "\033[1;32mDESATIVANDO BOT PWEB... \033[0m\n"
        fun_bot2() {
            screen -r -S "bot_painel" -X quit
            screen -wipe 1>/dev/null 2>/dev/null
            [[ $(grep -wc "bot_painel" /etc/autostart) != '0' ]] && {
                sed -i '/bot_painel/d' /etc/autostart
            }
            sleep 1
        }
        fun_bar 'fun_bot2'
        echo -e "\n\033[1;32m \033[1;31mBOT PWEB DESATIVADO! \033[0m"
        sleep 2
        /bin/ppweb/botpweb.sh
    }
}

fun_instbot() {
	stsbot=$(ps x | grep "bot_painel"|grep -v grep > /dev/null && echo -e "\033[1;31mDESATIVAR BOT" || echo -e "\033[1;32mATIVAR BOT")
	echo ""
    echo -e "\E[44;1;37m            GERENCIAR BOT PWEB               \E[0m\n"
	echo -e "             \033[1;33m[\033[1;31m!\033[1;33m] \033[1;31mATENÇÃO \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
    echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33m$stsbot \033[0m"
    echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mATUALIZAR BOT PWEB\033[0m"
    echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
    echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
tput civis
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read x
tput cnorm

clear
case $x in

1|01)
fun_botOnOff
exit;
;;
2|02)
fun_att_api
exit;
;;
0|00)
pweb
exit;
;;
*)
echo -e "\033[1;31mOpção inválida...\033[0m"
sleep 1
clear
/bin/ppweb/botpweb.sh
;;
esac
}
fun_instbot
#fim