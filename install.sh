#!/bin/bash

sudo apt-get -y update

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
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
sudo apt-get install -y lolcat

#install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

					echo "Installing Golang"
					wget https://dl.google.com/go/go1.19.1.linux-amd64.tar.gz
					sudo tar -xvf go1.19.1.linux-amd64.tar.gz
					sudo rm -rf /usr/local/go
					sudo rm -rf go1.19.1.linux-amd64.tar.gz
					sudo mv go /usr/local
					export GOROOT=/usr/local/go
					export GOPATH=$HOME/go
					export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
					echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
					echo 'export GOPATH=$HOME/go'	>>source ~/.bash_profile ~/.bash_profile			
					echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile	
					source ~/.bash_profile
					sleep 1
					break
					;;
				no)
					echo "Please install go and rerun this script"
					echo "Aborting installation..."
					exit 1
					;;
	esac	
done
fi

#create a worrdlists folder in ~/wordlists
mkdir ~/wordlists
cd ~/wordlists/
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
wget https://raw.githubusercontent.com/blechschmidt/massdns/master/lists/resolvers.txt
wget https://gist.githubusercontent.com/six2dez/ffc2b14d283e8f8eff6ac83e20a3c4b4/raw
mv raw perm.txt

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

echo "Installing pdtm"
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
pdtm -install-all
source ~/.bashrc
echo "done"

echo "Installing crobat"
go install  github.com/cgboal/sonarsearch/cmd/crobat@latest
echo "done"

echo "Installing assetfinder"
go get -u github.com/tomnomnom/assetfinder
echo "done"

echo "installing puredns"
go install github.com/d3mondev/puredns/v2@latest
echo "done"

echo "installing gotator"
go install github.com/Josue87/gotator@latest
echo "done"

echo "installing gowitness"
go install github.com/sensepost/gowitness@latest
echo "done"

echo "installing waybackurls"
go install github.com/tomnomnom/waybackurls@latest
echo "done"

echo "installing gau"
go install github.com/lc/gau/v2/cmd/gau@latest
echo "done"

echo "installing feroxbuster"
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
echo "done"

echo "installing ffuf"
go install github.com/ffuf/ffuf@latest
echo "done"

echo "installing gf"
go install github.com/tomnomnom/gf@latest
echo "done"

echo "installing Gf-Patterns"
mkdir .gf
sudo cp -r $GOPATH/pkg/mod/github.com/tomnomnom/gf*/examples/ ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns
sudo mv ~/tools/Gf-Patterns/*.json ~/.gf
echo "done"

echo "installing sqlmap"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo "done"

echo "installing unfurl"
go install github.com/tomnomnom/unfurl@latest
echo "done"

echo "installing CorsMe"
go install github.com/shivangx01b/CorsMe@latest
echo "done"

echo "installing ppmap"
go install github.com/kleiton0x00/ppmap@latest
echo "done"

echo "installing dalfox"
go install github.com/hahwul/dalfox/v2@latest
echo "done"

echo "installing ParamSpider"
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt
cd ~/tools/
echo "done"

echo "installing qsreplace"
go install github.com/tomnomnom/qsreplace@latest
echo "done"

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

sudo pip install urllib3==1.23 sudo pip install requests

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la