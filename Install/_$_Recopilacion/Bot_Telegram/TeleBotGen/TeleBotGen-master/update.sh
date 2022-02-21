#!/bin/bash

dirb="/etc/ADM-db" && [[ ! -d ${dirb} ]] && mkdir ${dirb}
dirs="${dirb}/sources" && [[ ! -d ${dirs} ]] && mkdir ${dirs}
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3J1ZGk5OTk5L1RlbGVCb3RHZW4vbWFzdGVyL3NvdXJjZXM="
SUB_DOM='base64 -d'
bar="\e[0;36m=====================================================\e[0m"

update () {
[[ -d ${dirs} ]] && rm -rf ${dirs}
[[ -e ${dirb} ]] && rm ${dirb}/BotGen.sh
[[ -e /bin/ShellBot.sh ]] && rm /bin/ShellBot.sh
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/lista-bot > /dev/null 2>&1
sleep 1s
if [[ -e $HOME/lista-arq ]]; then
for arqx in `cat $HOME/lista-arq`; do
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && [[ -e $HOME/$arqx ]] && veryfy_fun $arqx
done
fi
 rm $HOME/lista-arq
 start_bot
}

veryfy_fun () {
dirs="${dirb}/sources" && [[ ! -d ${dirs} ]] && mkdir ${dirs}
dirs="${dirb}/sources" && [[ ! -d ${dirs} ]] && mkdir ${dirs}
unset ARQ
case $1 in
"BotGen.sh")ARQ="${dirb}";;
*)ARQ="${dirs}";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

start_bot () {
# [[ ! -e "${CIDdir}/token" ]] && echo "null" > ${CIDdir}/token
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "BotGen.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS teleBotGen ${CIDdir}/BotGen.sh
else
killall BotGen.sh
fi
}

mensaje () {
 if [[ $1 = 1 ]]; then
  MENSAJE="Actualizando BotGen"
 elif [[ $1 = 2 ]]; then
  MENSAJE="BotGen Actualizado"
 fi
 TOKEN="$(cat ${dirb}/token)"
 ID="$(cat ${dirb}/Admin-ID)"
 URL="https://api.telegram.org/bot$TOKEN/sendMessage"
 curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE"
}

sleep 5
mensaje 1
sleep 1
update
sleep 1
mensaje 2
screen -dmS teleBotGen /etc/ADM-db/BotGen.sh
sleep 2
rm update.sh
