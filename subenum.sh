#!/bin/bash

if [ -z $1 ]
then
                echo "Usage: ./subenum.sh <domain list>" | lolcat
                exit 1

fi

clear
echo "++++ Alright, let's fetch us some subdomains using Subfinder, Assetfinder, Amass & ..." | lolcat

while read line
do
        for var in $line
        do
                echo "enumerating:" $var
                echo "...in progress..." | lolcat
                subfinder -d $1 -all | tee domains.$1.txt
				assetfinder --subs-only $1 | tee -a domains.$1.txt
				amass enum -d $1  | tee -a $1.amass
        done
done < $1

echo "++++ Running Puredns, dnsgen, massdns, gotator..." | lolcat
sleep 1
	puredns bruteforce /root/wordlists/subs/altdns.txt $1 -r /root/wordlists/resolvers.txt | tee  resolved.txt
	cat  * | sort -u | uniq  | tee $1_uniq
	cat $1_uniq | dnsgen - | massdns -r /root/wordlists/resolvers.txt -t A -o S -w massdns.txt 
	gotator -sub $1_uniq -perm /root/wordlists/subs/perm.txt -depth 3 -mindup | uniq | tee $1_perm.txt
	puredns resolve $1_perm.txt -r /root/wordlists/resolvers.txt

echo "++++ PROBING & FINDING ONLY ALIVE HOSTS!..." | lolcat
	cat $1_perm.txt | httpx | sort -u > $1_httpx.txt
	cat $1_httpx.txt | unfurl domains > anew $1_resolve.txt

echo "++++ Probing has been complete, enjoy your alive hosts and URLs under urls_alive..." | lolcat