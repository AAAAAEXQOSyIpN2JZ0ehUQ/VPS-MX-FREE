#!/bin/bash
#25/01/2021 by @Kalix1
clear
clear
SCPdir="/etc/VPS-MX"
SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${SCPdir}/protocolos"&& [[ ! -d ${SCPinst} ]] && exit
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
intallv2ray () {
apt install python3-pip -y 
source <(curl -sL https://www.dropbox.com/s/ukkyksfdo3lqqmc/install-v2ray.sh)
msg -ama "$(fun_trans "Intalado con Exito")!"
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
protocolv2ray () {
msg -ama "$(fun_trans "Escojer opcion 3 y poner el dominio de nuestra IP")!"
msg -bar
v2ray stream
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
dirapache="/usr/local/lib/ubuntn/apache/ver" && [[ ! -d ${dirapache} ]] && exit
tls () {
msg -ama "$(fun_trans "Activar o Desactivar TLS")!"
msg -bar
v2ray tls
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
portv () {
msg -ama "$(fun_trans "Cambiar Puerto v2ray")!"
msg -bar
v2ray port
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
stats () {
msg -ama "$(fun_trans "Estadisticas de Consumo")!"
msg -bar
v2ray stats
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
unistallv2 () {
source <(curl -sL https://www.dropbox.com/s/ukkyksfdo3lqqmc/install-v2ray.sh) --remove
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
infocuenta () {
v2ray info
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
SPR & 
msg -bar3
msg -bar
msg -tit
msg -ama "$(fun_trans "        INSTALADOR DE V2RAY (PASO A PASO) ")"
msg -bar
echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "INSTALAR V2RAY") "
echo -ne "\033[1;32m [2] > " && msg -azu "$(fun_trans "CAMBIAR PROTOCOLO") "
echo -ne "\033[1;32m [3] > " && msg -azu "$(fun_trans "ACTIVAR TLS") "
echo -ne "\033[1;32m [4] > " && msg -azu "$(fun_trans "CAMBIAR PUERTO V2RAY") "
echo -ne "\033[1;32m [5] > " && msg -azu "$(fun_trans "INFORMACION DE CUENTA")"
echo -ne "\033[1;32m [6] > " && msg -azu "$(fun_trans "ESTADISTICAS DE CONSUMO")"
echo -ne "\033[1;32m [7] > " && msg -azu "$(fun_trans "DESINTALAR V2RAY")"
echo -ne "$(msg -bar)\n\033[1;32m [0] > " && msg -bra "\e[97m\033[1;41m VOLVER \033[1;37m"
msg -bar
while [[ ${arquivoonlineadm} != @(0|[1-7]) ]]; do
read -p "Seleccione una Opcion [0-5]: " arquivoonlineadm
tput cuu1 && tput dl1
done
case $arquivoonlineadm in
1)intallv2ray;;
2)protocolv2ray;;
3)tls;;
4)portv;;
5)infocuenta;;
6)stats;;
7)unistallv2;;
0)exit;;
esac