#!/bin/bash

Red="\e[31m"			#--------- Red color
Light_red="\e[91m"		#--------- Light red color
Green="\e[32m"			#--------- Green color
Yellow="\e[33m"			#--------- Yellow color
Blue="\e[34m"			#--------- Blue color
Default="\e[39m"		#--------- Default color
Mage="\e[35m"			#--------- Magenta
Cyan="\e[36m"			#--------- Cyan

change_keyboard()
{
	printf "${Green}Changing Keyboard layout${Default}\n"
	sed -i "s/fr/us/g" /etc/default/keyboard > /dev/null
}

change_docker()
{
	printf "${Blue}Allow Docker usage for user42${Default}\n"
	usermod -aG docker $(whoami)
}

update_minikube()
{
	printf "${Red}MaJ minikube\n"
	wget -P /tmp --quiet "https://github.com/kubernetes/minikube/releases/download/v1.13.0/minikube-linux-x86_64"
	printf "Successfully downloaded minikube last version, updating...${Default}\n"
	mv /tmp/minikube-linux-x86_64 /tmp/minikube
	chmod +x /tmp/minikube
	mv /tmp/minikube /usr/local/bin
}

disable_services()
{
	printf "${Mage}Desactivating services\n"
	printf "disabling mysql\n"
	systemctl --quiet disable mysql
	printf "disabling nginx\n"
	systemctl --quiet disable nginx
	printf "disabling postgresql\n"
	systemctl --quiet disable postgresql
	printf "disabling redis-server\n${Default}"
	systemctl --quiet disable redis-server
}

install()
{
	printf "${Cyan}installing htop\n"
	apt-get install -y htop > /dev/null
	printf "installing nmap${Default}\n"
	apt-get install -y nmap > /dev/null

}

if [ "$1" == "-a" ];then
	change_keyboard
	change_docker
	update_minikube
	disable_services
	echo "restart the VM to apply"
fi

if [ "$1" == "-k" ];then
	change_keyboard
fi

if [ "$1" == "-d" ];then
	change_docker
fi

if [ "$1" == "-m" ];then
	update_minikube
fi

if [ "$1" == "-s" ];then
	disable_services
fi

if [ "$1" == "--test1212" ];then
	install
fi

if [ "$1" == "" ] || [ "$1" == "-h" ]; then
	printf "Usage:\n"
	printf " -h get help\n"
	printf " -a all service proposed\n"
	printf " -k change keyboard layout to US\n"
	printf " -d setup docker permissions\n"
	printf " -m update minikube\n"
	printf " -s disable some services\n"
	printf " --test1212 installer truc que j'aime bien\n"
fi
