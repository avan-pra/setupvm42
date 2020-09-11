echo "Changing Keyboard layout"
sed -i "s/fr/us/g" /etc/default/keyboard > /dev/null
echo "Allow Docker usage"
usermod -aG docker user42
echo "MaJ minikube"
wget -P /tmp --quiet "https://github.com/kubernetes/minikube/releases/download/v1.13.0/minikube-linux-x86_64" > /dev/null
mv /tmp/minikube-linux-x86_64 /tmp/minikube
chmod +x /tmp/minikube
mv /tmp/minikube /usr/local/bin
echo "Desactivating stupid services"
systemctl disable mysql
systemctl disable nginx
