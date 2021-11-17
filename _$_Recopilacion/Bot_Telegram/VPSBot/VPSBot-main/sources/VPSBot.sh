#!/bin/bash

#CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
SRC="sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
# CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
#[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://raw.githubusercontent.com/rudi9999/TeleBotGen/master/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE="==========================="

# Importando API
source ShellBot.sh
source ${SRC}/menu
source ${SRC}/ayuda
source ${SRC}/cache
source ${SRC}/invalido
source ${SRC}/status
source ${SRC}/reinicio
source ${SRC}/myip
source ${SRC}/id
source ${SRC}/comandos
source ${SRC}/update
source ${SRC}/comandline

# Token del bot
bot_token="$(cat token)"

# Inicializando el bot
ShellBot.init --token "$bot_token" --monitor --return map
ShellBot.username

download_file () {
# shellbot.sh editado linea 3986
user=User-ID
[[ -e ${CID} ]] && rm ${CID}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
local bot_retorno="ID user botgen\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="${return[file_path]}\n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html
return 0
}

msj_add () {
	      ShellBot.sendMessage --chat_id ${1} \
							--text "<i>$(echo -e $bot_retor)</i>" \
							--parse_mode html
}

upfile_fun () {
          ShellBot.sendDocument --chat_id ${message_chat_id[$id]}  \
                             --document @${1}
}

invalido_fun () {
local bot_retorno="$LINE\n"
         bot_retorno+="Comando invalido!\n"
         bot_retorno+="$LINE\n"
	     ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "<i>$(echo -e $bot_retorno)</i>" \
							--parse_mode html
	return 0	
}

msj_fun () {
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "<i>$(echo -e $bot_retorno)</i>" \
							--parse_mode html
	return 0
}

# Ejecutando escucha del bot
while true; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates); do
	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    echo $chatuser >&2
	    comando=(${message_text[$id]})
	    [[ ! -e "Admin-ID" ]] && echo "null" > Admin-ID
	    permited=$(cat Admin-ID)
	    comand
    done
done
