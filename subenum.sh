#!/bin/bash

if [ -z $1 ]
then
                echo "Usage: ./subenum.sh <domain list>" | lolcat
                exit 1

fi

clear
echo "++++ Alright, let's fetch us some subdomains using Subfinder & Amass" | lolcat

while read line
do
        for var in $line
        do
                echo "enumerating:" $var
                echo "...in progress..." | lolcat
                subfinder -d $var -all | tee domains.$var.txt
				amass enum -d $var  | tee -a $var.amass
        done
done < $1

echo "++++ Running Puredns, gotator..." | lolcat
sleep 1
	puredns -r ~/root/wordlists/resolvers.txt bruteforce ~/root/wordlists/best-dns-wordlist.txt $var | tee resolved.txt
	cat  * | sort -u | uniq  | tee $var_uniq
	gotator -sub $var_uniq -perm ~/root/wordlists/perm.txt -depth 3 -mindup | uniq | tee $var_perm.txt
	puredns resolve $var_perm.txt -r ~/root/wordlists/resolvers.txt

echo "++++ PROBING & FINDING ONLY ALIVE HOSTS!..." | lolcat
	cat $var_perm.txt | httpx | sort -u > $var_httpx.txt
	cat $var_httpx.txt | unfurl domains > anew $var_resolve.txt

echo "++++ Probing has been complete, enjoy your alive hosts and URLs under urls_alive..." | lolcat