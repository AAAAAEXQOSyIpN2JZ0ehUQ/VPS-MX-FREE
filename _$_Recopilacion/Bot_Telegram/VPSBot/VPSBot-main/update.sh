#!/bin/bash

dirb="/etc/VPSBot" && [[ ! -d ${dirb} ]] && mkdir ${dirb}
dirs="${dirb}/sources" && [[ ! -d ${dirs} ]] && mkdir ${dirs}
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3J1ZGk5OTk5L1ZQU0JvdC9tYWluL3NvdXJjZXM="
SUB_DOM='base64 -d'
bar="\e[0;36m=====================================================\e[0m"

update () {
[[ -d ${dirs} ]] && rm -rf ${dirs}
[[ -e ${dirb}/VPSBot.sh ]] && rm ${dirb}/VPSBot.sh
[[ -e /usr/bin/VPSBot ]] && rm /usr/bin/VPSBot
[[ -e ${dirb}/ShellBot.sh ]] && rm ${dirb}/ShellBot.sh
[[ -e ${dirb}/vpsbot_conf.sh ]] && rm ${dirb}/vpsbot_conf.sh
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/lista-bot > /dev/null 2>&1
sleep 1s
if [[ -e $HOME/lista-arq ]]; then
for arqx in `cat $HOME/lista-arq`; do
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && echo -e "\033[0;49;93mdescargando \033[0;49;32m${arqx}\033[0m" && [[ -e $HOME/$arqx ]] && veryfy_fun $arqx
done
fi
 rm $HOME/lista-arq
 echo "cd ${dirb}" > /usr/bin/VPSBot && echo './vpsbot_conf.sh' >> /usr/bin/VPSBot && chmod +x /usr/bin/VPSBot
}

veryfy_fun () {
dirs="${dirb}/sources" && [[ ! -d ${dirs} ]] && mkdir ${dirs}
unset ARQ
case $1 in
"VPSBot.sh")ARQ="${dirb}";;
"ShellBot.sh")ARQ="${dirb}";;
"vpsbot_conf.sh")ARQ="${dirb}";;
*)ARQ="${dirs}";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

mensaje () {
 if [[ $1 = updating ]]; then
  MENSAJE="Actualizando VPSBot..."
 elif [[ $1 = updated ]]; then
  MENSAJE="VPSBot Actualizado!"
 fi
 TOKEN="$(cat ${dirb}/token)"
 ID="$(cat ${dirb}/Admin-ID)"
 URL="https://api.telegram.org/bot$TOKEN/sendMessage"
 curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE"
}

clear
sleep 5
if [[ $1 = start ]]; then
	mensaje updating
	update
	mensaje updated
	cd ${dirb}
	screen -dmS VPSBot ./VPSBot.sh
else
	echo -e "\033[0;49;93m==============================\n INSTALANDO VPSBot\n==============================\033[0m"
	update
	echo -e "\033[0;49;93m==============================\n VPSBot INSTALADO\n==============================\n escriba \033[5;49;32mVPSBot \033[0;49;93mpara ejecutar\n==============================\033[0m"
fi

rm $HOME/update.sh
exit

