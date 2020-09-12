#Print commands
set -x

#Old version
old=$(cloudflared -v)

#Remove old version from home if it exists
test -f /home/pi/cloudflared && rm /home/pi/cloudflared
test -f /home/pi/cloudflared-stable-linux-arm.tgz && rm /home/pi/cloudflared-stable-linux-arm.tgz

#Check path via https://docs.pi-hole.net/guides/dns-over-https/
wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz

#Extract
tar -xvzf cloudflared-stable-linux-arm.tgz

#Stop cloudflared service
sudo systemctl stop cloudflared

#Copy new verion to /usr/local/bin overwriting old version
sudo cp ./cloudflared /usr/local/bin

#Set new version to be executable
sudo chmod +x /usr/local/bin/cloudflared

#Start cloudflared
sudo systemctl start cloudflared

#Tidy up home
rm cloudflared
rm cloudflared-stable-linux-arm.tgz

#New version
new=$(cloudflared -v)

#Stop printing commands
set +x

#Print old and new version numbers
echo "Old version: ""$old"""
echo "New version: ""$new"""
