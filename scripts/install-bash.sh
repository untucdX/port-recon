#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libpcap-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y whatweb
sudo apt-get install -y nikto
sudo apt-get install gcc libpq-dev -y
sudo apt-get install python-dev  python-pip -y
sudo apt-get install python3-dev python3-pip python3-venv python3-wheel -y

echo -e "\e[1;31m installing bash_profile aliases from recon_profile \e[0m"
git clone https://github.com/NetanMangal/recon_profile.git
cd recon_profile
cat .bash_profile >>~/.bash_profile
source ~/.bash_profile
echo -e "\e[1;31m done \e[0m"

echo "" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "if [ -f ~/.bash_profile ]; then" >> ~/.bashrc
echo "    . ~/.bash_profile" >> ~/.bashrc
echo "fi" >> ~/.bashrc


#install go
if [[ -z "$GOPATH" ]]; then
	echo -e "\e[1;31m Installing Golang \e[0m"
	wget https://dl.google.com/go/go1.17.1.linux-amd64.tar.gz
	sudo tar -xf go1.17.1.linux-amd64.tar.gz
	sudo mv go /usr/local
	export GOROOT=/usr/local/go
	export GOPATH=$HOME/go
	export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
	echo 'export GOROOT=/usr/local/go' >>~/.bash_profile
	echo 'export GOPATH=$HOME/go' >>~/.bash_profile
	echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >>~/.bash_profile
	source ~/.bash_profile
	sleep 1
else
	echo -e "\e[1;31m Go already installed \e[0m"
fi

# #Don't forget to set up AWS credentials!
# echo -e "\e[1;31m Don't forget to set up AWS credentials! \e[0m"
# sudo apt-get install -y awscli
# echo -e "\e[1;31m Don't forget to set up AWS credentials! \e[0m"

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/


#install nmap
echo -e "\e[1;31m installing nmap \e[0m"
sudo apt-get install -y nmap
echo -e "\e[1;31m done \e[0m"

#nmap scripts
sudo cd /usr/share/nmap/
sudo git clone https://github.com/scipag/vulscan scipag_vulscan
sudo ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan

#nmap scripts
cd /usr/share/nmap/scripts/
git clone https://github.com/vulnersCom/nmap-vulners.git
cd ~/tools/

#install sqlmap
echo -e "\e[1;31m installing sqlmap \e[0m"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install Nuclei
echo -e "\e[1;31m installing Nuclei \e[0m"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
nuclei -update-templates
mv ~/nuclei-templates/ ~/tools/
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install NetanMangal/recon
echo -e "\e[1;31m installing NetanMangal/recon \e[0m"
git clone https://github.com/NetanMangal/recon.git
echo -e "\e[1;31m done \e[0m"

#install smuggler.py
echo -e "\e[1;31m installing smuggler.py \e[0m"
git clone https://github.com/defparam/smuggler.git
sudo ln -sfv /home/runner/tools/smuggler/smuggler.py /usr/bin/smuggler
echo -e "\e[1;31m done \e[0m"

#install httprobe
echo -e "\e[1;31m installing httprobe \e[0m"
go install -v github.com/tomnomnom/httprobe@latest
echo -e "\e[1;31m done \e[0m"

#install naabu
echo -e "\e[1;31m installing naabu \e[0m"
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
echo -e "\e[1;31m done \e[0m"

#install httpx
echo -e "\e[1;31m installing httpx \e[0m"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo -e "\e[1;31m done \e[0m"

#install ffuf
echo -e "\e[1;31m installing ffuf \e[0m"
go install -v github.com/ffuf/ffuf@latest
echo -e "\e[1;31m done \e[0m"


echo -e "\e[1;34m Resourcing bash_profile \e[0m"
sleep 1
source ~/.bash_profile
sleep 2

echo -e "\n\n\n\n\n\n\n\n\n\n\n\e[1;31m Done! All tools are set up in ~/tools \e[0m"
ls -la
