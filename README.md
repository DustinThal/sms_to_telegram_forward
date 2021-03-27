# sms_to_telegram_forward
a "simple" forwarde from sms messages to telegram

helpful if you want to share accounts that have a SMS authetication with friends. e.g. Netflix

I use my TrueNAS and a cloneJail for this.
Used Hardware Banggood SIM800C usb stick: 
https://www.banggood.com/de/LC-GSM-SIM800C-2-USB-to-GSM-Serial-Port-GPRS-SIM800C-Module-with-bluetooth-Computer-Control--p-1420413.html?cur_warehouse=CN&rmmds=search

Installation:

1. clone jail erstellen, mine =smsrouter

2. Einrichten des "usb-durchschleifen" : https://petermolnar.net/article/freenas-domoticz-zigbee-zwave-rflink/
   modifizierte Datein für SIM800C von Banggood sind hier im Ordner
   
   1. ordner erstelle unter /mnt/[Pool für Jails]/bin
   
   2. Datein reinkopieren prestart_usb.sh / poststart_smsrouter.sh (z.B. /mnt/systempool/bin/poststart_smsrouter.sh)
   
   3. chmod +x/mnt/[Pool für Jails]/bin/prestart_usb.sh | chmod +x/mnt/[Pool für Jails]/bin/poststart_smsrouter.sh
   
   4. Jail Properties ->   devfs_ruleset -> 5
                           exec_poststart -> /mnt/systempool/bin/poststart_smsrouter.sh
   
   5. TrueNAS -> Tasks -> Init/Shutdown Script -> ADD [Type=Script, Script*=z.B. /mnt/systempool/bin/prestart_usb.sh, When=Post Init]

3. in der Jail ausführen:
   pkg update
   pkg install npm
   npm install -g --unsafe-perm node-red
   npm install pm2 -g
   pm2 start node-red
   pm2 save
   pm2 startup
   pm2 save
   npm i node-telegram-bot-api
   npm i socks5-https-client
   
4. mit Hilfe von: https://forum.iobroker.net/topic/26058/sms-und-oder-anruf-mit-sim800-modul-und-node-red habe ich die kommenden Teile erstellt:

5. chatId muss geändert werden
