this repo sets up a phishing email training host.






the process is started with

./general_setup_docker.sh {target domain} {IP address of server} {email test destination} {hostname of the email host}


This setup expects, that under the given server ip there is a ubuntu installation, which can be accessed as root with an already installed ssh public key.




after install, you can run the following script which opens the 

ssh root@{server ip}
cd 
./phishing_sender/open_interface.sh

tmux a
