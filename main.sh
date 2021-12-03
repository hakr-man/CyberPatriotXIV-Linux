#!/bin/bash
#update
sudo apt-get update && sudo apt-get upgrade

#UFW
sudo apt install ufw -y
sudo ufw reset

#ask what things are installed

# have a text file with as many programs as we can think of, then use a for loop running cat to get each program
# individually. We can then ask if the program is installed, and set a boolean with the name of the selected program
# and audit accordingly
#
# In the future I would like to automatically read all installed apt and snap packages and write them to either an array
# or a file that this section can read

#for i in `cat programs.txt`
#do 
#    echo $i + "?"
#    read input
#    if [ "$input" = "y" ]; then
#    $i=TRUE
#fi

#done


echo SSH?
read ssh
if [ "$ssh" = "y" ]; then
sudo ufw limit 22/tcp
echo allowing port 22
fi

echo Apache2 or nginx?
read webserver
if [ "$webserver" = "y" ]; then
echo allowing ports 80&443
sudo ufw allow 80/tcp && sudo ufw allow 443/tcp
fi

echo FTP?
read ftp
if [ "$ftp" = "y" ]; then
echo allowing port 22
sudo ufw limit 22/tcp

fi
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw status
sudo ufw enable



#Services
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

# just a reminder that # is to comment and that capital letters screw up cmds

sudo apt-get remove --purge netcat-openbsd netcat-traditional openbsd-inetd kismet wireshark nmap zenmap ophcrack john apache2 nginx nginx-common nginx-full bind9 rpcbind rsh-server rsh-client rsh-redone-client pure-ftpd samba os-prober freeciv telnet telnetd telnet-server talk tcpd tcpdump telepathy remmina ppp smbclient libsmbclient mysql-server postgresql crack crack-common logkeys hydra fakeroot nikto bind cupsd vuze vsftpd ftp aisleriot nis ldap-utils transmission transmissions-gtk qbittorrent nzbget sabnzbd sabnzbdplus docker

#Security
sudo apt install clamtk
#Logs
sudo apt install auditd
auditctl -e 1

#MOTD/Banners
chown root:root /etc/motd
chmod 644 /etc/motd
chown root:root /etc/issue
chmod 644 /etc/issue
chown root:root /etc/issue.net
chmod 644 /etc/issue.net
echo user-db:user 
system-db:gdm 
file-db:/usr/share/gdm/greeter-dconf-defaults "" > echo /etc/dconf/profile/gdm
dconf update













