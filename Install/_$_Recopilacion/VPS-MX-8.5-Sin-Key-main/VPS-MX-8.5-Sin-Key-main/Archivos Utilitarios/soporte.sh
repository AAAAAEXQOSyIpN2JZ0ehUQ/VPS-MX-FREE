#/bin/bash
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ifconfig.me)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
fun_ip () {
MIP2=$(wget -qO- ifconfig.me)
MIP=$(wget -qO- whatismyip.akamai.com)
if [ $? -eq 0 ]; then
IP="$MIP"
else
IP="$MIP2"
fi
}
function_verify () {
permited=$(curl -sSL "https://www.dropbox.com/s/nmau2w8vebewpq3/control-IP")
[[ $(echo $permited|grep "${IP}") = "" ]] && {
clear
echo -e "\n\n\n\033[1;91m————————————————————————————————————————————————————\n      ¡ESTA KEY NO CONCUERDA CON EL INSTALADOR! \n    \n————————————————————————————————————————————————————\n\n\n"
[[ -d /etc/VPS-MX ]] && rm -rf /etc/VPS-MX
exit 1
} || {
v1=$(curl -sSL "https://raw.githubusercontent.com/lacasitamx/VPSMX/master/SCRIPT-8.4/Vercion")
echo "$v1" > /etc/versin_script
}
}
echo -e "\033[0;37m BIENVENIDO A SOPORTE ONLINE (APLICANDO FIX's)"
[[ ! -d /usr/local/lib ]] && mkdir /usr/local/lib
[[ ! -d /usr/local/lib/ubuntn ]] && mkdir /usr/local/lib/ubuntn
[[ ! -d /usr/local/lib/ubuntn/apache ]] && mkdir /usr/local/lib/ubuntn/apache
[[ ! -d /usr/local/lib/ubuntn/apache/ver ]] && mkdir /usr/local/lib/ubuntn/apache/ver
[[ ! -d /usr/share ]] && mkdir /usr/share
[[ ! -d /usr/share/mediaptre ]] && mkdir /usr/share/mediaptre
[[ ! -d /usr/share/mediaptre/local ]] && mkdir /usr/share/mediaptre/local
[[ ! -d /usr/share/mediaptre/local/log ]] && mkdir /usr/share/mediaptre/local/log
[[ ! -d /usr/share/mediaptre/local/log/lognull ]] && mkdir /usr/share/mediaptre/local/log/lognull
[[ ! -d /etc/VPS-MX/B-VPS-MXuser ]] && mkdir /etc/VPS-MX/B-VPS-MXuser
[[ ! -d /usr/local/protec ]] && mkdir /usr/local/protec
[[ ! -d /usr/local/protec/rip ]] && mkdir /usr/local/protec/rip
[[ ! -d /etc/protecbin ]] && mkdir /etc/protecbin
rm -rf /etc/VPS-MX/herramientas/speed.sh
rm -rf /etc/VPS-MX/herramientas/speedtest.py
cd /etc/VPS-MX/herramientas
wget https://raw.githubusercontent.com/lacasitamx/VPSMX/master/code/speedtest_v1.tar >/dev/null 2>&1
tar -xf speedtest_v1.tar > /dev/null 2>&1
rm -rf speedtest_v1.tar > /dev/null 2>&1
cd
[[ ! -d /etc/VPS-MX/v2ray ]] && mkdir /etc/VPS-MX/v2ray
[[ ! -d /etc/VPS-MX/Slow ]] && mkdir /etc/VPS-MX/Slow
[[ ! -d /etc/VPS-MX/Slow/install ]] && mkdir /etc/VPS-MX/Slow/install
[[ ! -d /etc/VPS-MX/Slow/Key ]] && mkdir /etc/VPS-MX/Slow/Key
echo -e "\033[0;92m FICHEROS AGREGADOS"'