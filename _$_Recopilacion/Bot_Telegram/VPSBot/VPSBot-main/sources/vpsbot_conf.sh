#!/bin/bash

msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
COLOR[7]='\033[1;49;95m'
COLOR[8]='\033[1;49;96m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
8)COLOR[$COL]='\033[1;49;95m';;
9)COLOR[$COL]='\033[1;49;96m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -aqua)cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${COLOR[0]}${SEMCOR}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${COLOR[7]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

menu_func () {
local options=${#@}
local array
for((num=1; num<=$options; num++)); do
echo -ne "$(msg -verd "[$num]") $(msg -aqua ">") "
  array=(${!num})
  case ${array[0]} in
    "-vd")msg -verd "\033[1;33m[!]\033[1;32m ${array[@]:1}" | sed ':a;N;$!ba;s/\n/ /g';;
    "-vm")msg -verm2 "\033[1;33m[!]\033[1;31m ${array[@]:1}" | sed ':a;N;$!ba;s/\n/ /g';;
    "-fi")msg -azu "${array[@]:2} ${array[1]}" | sed ':a;N;$!ba;s/\n/ /g';;
	*)msg -azu "${array[@]}" | sed ':a;N;$!ba;s/\n/ /g';;
  esac
done
}

# SISTEMA DE SELECAO
selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37mSelecione una Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection 
}

ini_token () {
clear
msg -bar
echo -e "  \033[1;37mIngrese el token de su bot"
msg -bar
echo -n "TOKEN: "
read opcion
echo "$opcion" > token
msg -bar
echo -e "  \033[1;32mtoken se guardo con exito!" && msg -bar && echo -e "  \033[1;37mPara tener acceso a todos los comandos del bot\n  deve iniciar el bot en la opcion 2.\n  desde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/id\n  \033[1;37mel bot le respodera con su ID de telegram.\n  copiar el ID e ingresar el mismo en la opcion 3" && msg -bar
read foo
}

ini_id () {
clear
msg -bar
echo -e "  \033[1;37mIngrese su ID de telegram"
msg -bar
echo -n "ID: "
read opcion
echo "$opcion" > Admin-ID
msg -bar
echo -e "  \033[1;32mID guardo con exito!" && msg -bar && echo -e "  \033[1;37mdesde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/menu\n  \033[1;37mprueve si tiene acceso al menu extendido." && msg -bar
read foo
return
}

start_bot () {
[[ ! -e "token" ]] && echo "null" > token
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "VPSBot.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS VPSBot ./VPSBot.sh
else
killall VPSBot.sh
fi
}

ayuda_fun () {
clear
msg -bar
echo -e "            \e[47m\e[30m Instrucciones rapidas \e[0m"
msg -bar
echo -e "\033[1;37m   Es necesario crear un bot en \033[1;32m@BotFather "
msg -bar
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
msg -bar
read foo
}

update () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "VPSBot.sh")
[[ $PIDGEN ]] && killall VPSBot.sh
[[ -e $HOME/update.sh ]] && rm $HOME/update.sh
wget -O $HOME/update.sh https://raw.githubusercontent.com/rudi9999/VPSBot/main/update.sh &> /dev/null
chmod +x $HOME/update.sh
$HOME/update.sh
exit
}

clear
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "VPSBot.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moffline" || PID_GEN="\033[1;32monline"
msg -bar && msg -bra "\033[7;49;35m                      VPSBOT                         "
msg -bar
menu_func 'TOKEN\nDEL\nBOT' "INICIAR/PARAR\nBOT\n$PID_GEN\033[0m" "ID\nDE\nUSUARIO\nTELEGRAM" "ACTUALIZAR" "AYUDA"
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mSALIR DEL SCRIPT"
msg -bar
selection=$(selection_fun 5)
case ${selection} in
1)ini_token;;
2)start_bot;;
3)ini_id;;
4)update;;
5)ayuda_fun;;
0)cd $HOME && exit 0;;
esac
VPSBot