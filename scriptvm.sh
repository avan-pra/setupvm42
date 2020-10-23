#!/bin/bash

Red="\e[31m"			#--------- Red color
Light_red="\e[91m"		#--------- Light red color
Green="\e[32m"			#--------- Green color
Yellow="\e[33m"			#--------- Yellow color
Blue="\e[34m"			#--------- Blue color
Default="\e[39m"		#--------- Default color
Mage="\e[35m"			#--------- Magenta
Cyan="\e[36m"			#--------- Cyan
Orange="\e[33m"			#--------- orange
Bold="\e[01m"			#--------- bold

change_keyboard()
{
	printf "${Green}Changing Keyboard layout${Default}\n"
	sed -i "s/fr/us/g" /etc/default/keyboard > /dev/null
}

change_docker()
{
	printf "${Blue}Allow Docker usage for user42${Default}\n"
	usermod -aG docker user42
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
	printf "disabling redis-server\n"
	systemctl --quiet disable redis-server

}

install()
{
	printf "${Cyan}installing htop${Default}\n"
	sudo apt-get install -y htop > /dev/null
	printf "${Cyan}installing nmap${Default}\n"
	sudo apt-get install -y nmap > /dev/null
	printf "${Light_red}if the install isnt working try --apt restart and try again${Default}\n"
}

apt()
{
	printf "${Orange}disabling apt auto-update\n${Default}"
	sed -i "s/1/0/g" /etc/apt/apt.conf.d/20auto-upgrades
}

helpp()
{
	printf "${Bold}Usage:\n"
	printf " -h get help\n"
	printf " -a all\n"
	printf " -k change keyboard layout to US\n"
	printf " -d setup docker permissions\n"
	printf " -m update minikube\n"
	printf " -s disable some services\n"
	printf " --test1212 install some useful program${Default}\n"
}

if [ $(whoami) != "root" ];then
	printf "${Red}Run as root${Default}\n"
	exit
fi

if [ "$1" == "-a" ];then
	change_keyboard
	change_docker
	update_minikube
	disable_services
	apt
	echo "restart the VM to apply"
elif [ "$1" == "--apt" ];then
	apt
elif [ "$1" == "-k" ];then
	change_keyboard
elif [ "$1" == "-d" ];then
	change_docker
elif [ "$1" == "-m" ];then
	update_minikube
elif [ "$1" == "-s" ];then
	disable_services
elif [ "$1" == "--test1212" ];then
	install
else
	helpp
fi
