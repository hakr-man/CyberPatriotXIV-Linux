#!/bin/bash
#update
sudo apt-get update && sudo apt-get upgrade
if $? = 0 

then
  echo "apt-get update/upgrade complete" >> log.txt
else
  echo "apt-get update/upgrade failed" >> log.txt
fi
#get installed programs to programs.txt
dpkg -l > programs.txt

# In the future I would like to automatically read all installed apt and snap packages and write them to either an array
# or a file that this section can read

awk 'NR==FNR {a[$1]++; next} $1 in a' badthings.txt programs.txt >> toremove.txt #saves all bad programs to file
echo "wrote bad programs to toremove.txt" >> log.txt
# need an input for all critcal programs, and then to set booleans accordingly to use throughout the script
# gonna use a text file with all critcal programs manually typed in from the README.

#UFW
sudo apt install ufw -y | echo "installed ufw" >> log.txt
sudo ufw reset | echo "reset ufw" >> log.txt
# start of ufw
if grep -q ssh "critical.txt"; then
  sudo ufw limit 22/tcp
  echo 'allowed port 22/tcp for ssh' >> log.txt
fi
if grep -q webserver "critical.txt"; then
    sudo ufw allow 80/tcp && sudo ufw allow 443/tcp
    echo 'allowed port 80/tcp & 443/tcp' >> log.txt
fi
if grep -q ftp "critical.txt"; then
sudo ufw allow 22/tcp
echo 'allowed port 22' >> log.txt
fi
sudo ufw default deny incoming
sudo ufw default allow outgoing
echo 'set ufw default rules' >> log.txt
sudo ufw status >> log.txt
sudo ufw enable >> log.txt
echo ufw enabled >> log.txt



#Services 
#CHANGE THESE TO FOLLOW THE SAME RULES AS UFW/USE INSTALLED PROGRAM LIST
service apache2 stop
systemctl disable apache2
service ssh stop
systemctl disable ssh
service nginx stop
systemctl disable nginx
service vsftpd stop
systemctl disable vsftpd
service rsh stop
systemctl disable rsh
service cups stop
systemctl disable cups
service xinetd stop
systemctl disable xinetd
service isc-dhcp-server stop
systemctl disable isc-dhcp-server
service  nfs-server stop
systemctl disable  nfs-server
service rpcbind stop
systemctl disable rpcbind
service bind9 stop
systemctl disable bind9
service avahi-daemon stop
systemctl disable avahi-daemon
service smbd stop
systemctl disable smbd
service rsync stop
systemctl disable rsync
service nis stop
systemctl disable nis
service squid stop
systemctl disable squid
for i in {1..5} 
do
echo 'REMEMBER TO RESTART CRITICAL SERVICES!' >> log.txt
done

# just a reminder that # is to comment and that capital letters screw up cmds
#this remove one-liner is still dumb rn, woring on modular uninstall section
sudo apt-get remove --purge netcat-openbsd netcat-traditional openbsd-inetd kismet wireshark nmap zenmap ophcrack john apache2 nginx nginx-common nginx-full bind9 rpcbind rsh-server rsh-client rsh-redone-client pure-ftpd samba os-prober freeciv telnet telnetd telnet-server talk tcpd tcpdump telepathy remmina ppp smbclient libsmbclient mysql-server postgresql crack crack-common logkeys hydra fakeroot nikto bind cupsd vuze vsftpd ftp aisleriot nis ldap-utils transmission transmissions-gtk qbittorrent nzbget sabnzbd sabnzbdplus docker
echo 'removed bad programs' >> log.txt
#Security
sudo apt install clamtk
echo 'installed clamtk' >> log.txt
#Logs
sudo apt install auditd
auditctl -e 1
echo 'set up logs' >> log.txt
#MOTD/Banners

#chown root:root /etc/motd
#chmod 644 /etc/motd
#chown root:root /etc/issue
#chmod 644 /etc/issue
#chown root:root /etc/issue.net
#chmod 644 /etc/issue.net
#echo user-db:user 
#system-db:gdm 
#file-db:/usr/share/gdm/greeter-dconf-defaults "" > echo /etc/dconf/profile/gdm
#dconf update
#comment

#DISABLED THIS, IDK WHAT IT REALLY DOES AND I DONT KNOW HOW TO FIX IT
#chown root:root /etc/motd
#chmod 644 /etc/motd
#chown root:root /etc/issue
#chmod 644 /etc/issue
#chown root:root /etc/issue.net
#chmod 644 /etc/issue.net
#echo user-db:user 
#system-db:gdm 
#file-db:/usr/share/gdm/greeter-dconf-defaults "" > echo /etc/dconf/profile/gdm
#dconf update
#echo 'motd/banners done' >> log.txt
#LYNIS TIME
#rushing to get a release out before next comp so gonna cut automatic auditing, will write lynis output to lynis.txt
sudo apt-get install lynis
echo 'lynis installed' >> log.txt
lynis audit system > lynix.txt
echo 'lynis written' >> log.txt
