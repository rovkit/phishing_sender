#!/bin/bash

#example usage:
#
#./general_setup_docker.sh example.com 1.1.1.1 joe@example.org mailtest.example.org

print_exit () {
  echo "example usage:"
  echo "please use a ubuntu machine, the docker ubuntu version is used."
  echo "./general_setup_docker.sh example.com 1.1.1.1 joe@example.org mailtest.example.org"
  exit
}


#ip configuration
if [ -z "$1" ]; then
	echo "please provide a target domain"
	print_exit
else
  target_server=$1
fi

#target server limitation config
if [ -z "$2" ]; then
	echo "please tell me the ip where the mail sender should be set up"
	print_exit
else
  host_ip=$2
fi


#test mail address
if [ -z "$3" ]; then
	echo "please provide a test email address"
	print_exit
else
  test_mail=$3
fi


#server sending host
if [ -z "$4" ]; then
	echo "please provide a sender hostname for the sending of the mails"
	print_exit
else
  mail_host=$4
fi


echo "running with following config:"
echo "target_server=$target_server; host_ip=$host_ip;test_mail=$test_mail; mail_host=$mail_host;"
ssh root@$host_ip "mkdir -p /root/phishing_sender"
scp -r * root@95.216.140.158:/root/phishing_sender 



ssh root@$host_ip << ENDSSH

echo "installing necessary packets"

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install -y tmux
apt install -y ssmtp
apt install -y mailutils
apt install -y git
apt install -y docker-compose 

#gophish dependencies: 
apt install -y golang-go gcc unzip

apt install -y telnet

#mailhub auf localhost stellen
sed -i 's/mailhub=.*/mailhub=localhost/' /etc/ssmtp/ssmtp.conf


#TODO: remove mailtest
mkdir mailtest
cd mailtest
echo -e 'From: mail@example.com \nSubject: sendmail test two \nTesting email body' >> mail.txt
echo "sendmail $test_mail  < mail.txt" >> mailtest.sh
chmod +x mailtest.sh
cd ../


cd phishing_sender/

./install_gophish.sh

#optional: load local image
docker load -i centos_image.tar

cd eesender

echo "starting mailservers setup"


echo "server setup as:"
echo "./run_eesender.sh $target_server $mail_host"


#starting tmux session with docker postfix container
tmux new-session -d -s testserver
tmux send "./run_eesender.sh $target_server $mail_host" ENTER;







ENDSSH



ssh root@$host_ip "tmux a"




