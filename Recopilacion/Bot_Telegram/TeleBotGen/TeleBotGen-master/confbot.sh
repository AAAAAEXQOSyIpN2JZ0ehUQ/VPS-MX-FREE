#!/bin/bash

SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3J1ZGk5OTk5L1RlbGVCb3RHZW4vbWFzdGVyL3NvdXJjZXM="
SUB_DOM='base64 -d'
bar="\e[0;36m=====================================================\e[0m"

check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

function_verify () {
  permited=$(curl -sSL "https://www.dropbox.com/s/8918s8z3py6jq7r/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  echo -e "\n\n\n\e[31m====================================================="
  echo -e "\e[31m      ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!\n     SI DESEAS USAR EL BOTGEN CONTACTE A @Rufu99"
  echo -e "\e[31m=====================================================\n\n\n\e[0m"
  [[ -d /etc/ADM-db ]] && rm -rf /etc/ADM-db
[[ ! -e "/bin/ShellBot.sh" ]] && rm /bin/ShellBot.sh
  exit 1
  } || {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/rudi9999/TeleBotGen/master/Vercion")
  echo "$v1" > /etc/ADM-db/vercion
  }
}

veryfy_fun () {
SRC="/etc/ADM-db/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
unset ARQ
case $1 in
"BotGen.sh")ARQ="/etc/ADM-db/";;
*)ARQ="/etc/ADM-db/sources/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

download () {
clear
echo -e "$bar"
echo -e "\033[1;33mDescargando archivos... "
echo -e "$bar"
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/lista-bot > /dev/null 2>&1
sleep 1s
[[ -e $HOME/lista-arq ]] && {
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33mDescargando: \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && {
echo -e "\033[1;31m- \033[1;32mRecibido!"
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
} || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
done
 }
 rm $HOME/lista-arq
}

ini_token () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el token de su bot"
echo -e "$bar"
echo -n "TOKEN: "
read opcion
echo "$opcion" > ${CIDdir}/token
echo -e "$bar"
echo -e "  \033[1;32mtoken se guardo con exito!" && echo -e "$bar" && echo -e "  \033[1;37mPara tener acceso a todos los comandos del bot\n  deve iniciar el bot en la opcion 2.\n  desde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/id\n  \033[1;37mel bot le respodera con su ID de telegram.\n  copiar el ID e ingresar el mismo en la opcion 3" && echo -e "$bar"
read foo
bot_gen
}

ini_id () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese su ID de telegram"
echo -e "$bar"
echo -n "ID: "
read opcion
echo "$opcion" > ${CIDdir}/Admin-ID
echo -e "$bar"
echo -e "  \033[1;32mID guardo con exito!" && echo -e "$bar" && echo -e "  \033[1;37mdesde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/menu\n  \033[1;37mprueve si tiene acceso al menu extendido." && echo -e "$bar"
read foo
bot_gen
}

start_bot () {
[[ ! -e "${CIDdir}/token" ]] && echo "null" > ${CIDdir}/token
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "BotGen.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS teleBotGen ${CIDdir}/BotGen.sh
clear
echo -e "$bar"
echo -e "\033[1;32m                BotGen en linea"
echo -e "$bar"
echo -ne "\033[1;97m Poner en linea despues de un reinicio [s/n]: "
read bot_ini
echo -e "$bar"
[[ $bot_ini = @(s|S|y|Y) ]] && {
	crontab -l > /root/cron
	echo "@reboot screen -dmS teleBotGen ${CIDdir}/BotGen.sh" >> /root/cron
	crontab /root/cron
	rm /root/cron
}
else
killall BotGen.sh
crontab -l > /root/cron
sed -i '/BotGen.sh/ d' /root/cron
crontab /root/cron
rm /root/cron
clear
msg -bar
echo -e "\033[1;31m            BotGen fuera de linea"
msg -bar
sleep 3
fi
bot_gen
}

ayuda_fun () {
clear
echo -e "$bar"
echo -e "            \e[47m\e[30m Instrucciones rapidas \e[0m"
echo -e "$bar"
echo -e "\033[1;37m   Es necesario crear un bot en \033[1;32m@BotFather "
echo -e "$bar"
echo -e "\033[1;32m1- \033[1;37mEn su apps telegram ingrese a @BotFather"
echo -e "\033[1;32m2- \033[1;37mDigite el comando \033[1;31m/newbot"
echo -e "\033[1;32m3- @BotFather \033[1;37msolicitara que\n   asigne un nombre a su bot"
echo -e "\033[1;32m4- @BotFather \033[1;37msolicitara que asigne otro nombre,\n   esta vez deve finalizar en bot eje: \033[1;31mXXX_bot"
echo -e "\033[1;32m5- \033[1;37mObtener token del bot creado.\n   En \033[1;32m@BotFather \033[1;37mdigite el comando \033[1;31m/token\n   \033[1;37mseleccione el bot y copie el token."
echo -e "\033[1;32m6- \033[1;37mIngrese el token\n   en la opcion \033[1;32m[1] \033[1;31m> \033[1;37mTOKEN DEL BOT"
echo -e "\033[1;32m7- \033[1;37mPoner en linea el bot\n   en la opcion \033[1;32m[2] \033[1;31m> \033[1;37mINICIAR/PARAR BOT"
echo -e "\033[1;32m8- \033[1;37mEn su apps telegram, inicie el bot creado\n   digite el comando \033[1;31m/id \033[1;37mel bot le respondera\n   con su ID de telegran (copie el ID)"
echo -e "\033[1;32m9- \033[1;37mIngrese el ID en la\n   opcion \033[1;32m[3] \033[1;31m> \033[1;37mID DE USUARIO TELEGRAM"
echo -e "\033[1;32m10-\033[1;37mcomprueve que tiene acceso a\n   las opciones avanzadas de su bot."
echo -e "$bar"
read foo
bot_gen
}

bot_conf () {
check_ip
function_verify
instaled=/etc/ADM-db/sources && [[ ! -d ${instaled} ]] && download
bot_gen
}

msj_prueba () {

TOKEN="$(cat /etc/ADM-db/token)"
ID="$(cat /etc/ADM-db/Admin-ID)"

[[ -z $TOKEN ]] && {
	clear
	echo -e "$bar"
	echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
	echo -e "$bar"
	read foo
} || {
	[[ -z $ID ]] && {
		clear
		echo -e "$bar"
		echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
		echo -e "$bar"
		read foo
	} || {
		MENSAJE="Esto es un mesaje de prueba!"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" &>/dev/null
		clear
		echo -e "$bar"
		echo -e "\033[1;37m mensaje enviado...!"
		echo -e "$bar"
		sleep 2
	}
}

bot_gen
}

bot_gen () {
clear
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "BotGen.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moffline" || PID_GEN="\033[1;32monline"

CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
echo -e "$bar"
echo -e "     \e[47m \e[30m>>>>>>  BotGen by \e[1;36mRufu99\e[1;32m  $(cat ${CIDdir}/vercion)\e[0m\e[47m \e[30m<<<<<< \e[0m"
echo -e "$bar"
echo -e "\033[1;32m[1] \033[1;36m> \033[1;37mTOKEN DEL BOT"
echo -e "\033[1;32m[2] \033[1;36m> \033[1;37mINICIAR/PARAR BOT $PID_GEN\033[0m"
echo -e "\033[1;32m[3] \033[1;36m> \033[1;37mID DE USUARIO TELEGRAM"
echo -e "\033[1;32m[4] \033[1;36m> \033[1;37mMENSAJE DE PRUEBA"
echo -e "\033[1;32m[5] \033[1;36m> \033[1;37mMANUAL"
echo -e "$bar"
echo -e "\e[1;32m[0] \e[36m>\e[0m \e[47m\e[30m <<ATRAS "
echo -e "$bar"
echo -n "Opcion: "
read opcion
case $opcion in
0) ;;
1) ini_token;;
2) start_bot;;
3) ini_id;;
4) msj_prueba;;
5) ayuda_fun;;
*) bot_gen;;
esac
}