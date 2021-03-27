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
   
4. kommt noch
