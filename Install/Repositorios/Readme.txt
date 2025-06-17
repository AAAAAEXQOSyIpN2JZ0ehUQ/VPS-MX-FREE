📦 Actualización de Repositorios APT para Ubuntu

En algunos casos, las versiones antiguas de Ubuntu (16.04 y 18.04) pueden presentar problemas con los repositorios oficiales debido al fin de soporte (EOL). Para resolver esto, puedes actualizar la lista de fuentes (sources.list) utilizando versiones alternativas mantenidas por la comunidad o ajustadas para scripts de instalación.

❗ Recomendación: Haz una copia de seguridad de tu archivo actual antes de reemplazarlo.

cp /etc/apt/sources.list /etc/apt/sources.list.bak

🔧 Ubuntu 16.04 (Xenial)

wget -O /etc/apt/sources.list https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MX-FREE/main/Install/Repositorios/16.04/sources.list

🔧 Ubuntu 18.04 (Bionic)

wget -O /etc/apt/sources.list https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MX-FREE/main/Install/Repositorios/18.04/sources.list


📌 Luego de actualizar los repositorios, ejecuta:

apt-get update -y && apt-get upgrade -y

Esto asegurará que tu sistema esté utilizando los repositorios actualizados y que todos los paquetes estén al día.
