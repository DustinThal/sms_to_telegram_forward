# sms_to_telegram_forward
a "simple" forwarde from sms messages to telegram

# This is only a proof of concept if 2FA like planned in NETFLIX will be forwarded to telegram.
# keep in mind that accountsharing will be illegal in your country

I use my TrueNAS and a cloneJail for this.
Used Hardware Banggood SIM800C usb stick: 
https://www.banggood.com/de/LC-GSM-SIM800C-2-USB-to-GSM-Serial-Port-GPRS-SIM800C-Module-with-bluetooth-Computer-Control--p-1420413.html?cur_warehouse=CN&rmmds=search

### Installation:

##### 1. clone jail erstellen, mine =smsrouter

##### 2. Einrichten des "usb-durchschleifen" : https://petermolnar.net/article/freenas-domoticz-zigbee-zwave-rflink/
   modifizierte Datein für SIM800C von Banggood sind hier im Ordner
   
   1. ordner erstelle unter /mnt/[Pool für Jails]/bin
   
   2. Datein reinkopieren prestart_usb.sh / poststart_smsrouter.sh (z.B. /mnt/systempool/bin/poststart_smsrouter.sh)
   
   3. chmod +x/mnt/[Pool für Jails]/bin/prestart_usb.sh | chmod +x/mnt/[Pool für Jails]/bin/poststart_smsrouter.sh
   
   4. Jail Properties ->   devfs_ruleset -> 5
                           exec_poststart -> /mnt/systempool/bin/poststart_smsrouter.sh
   
   5. TrueNAS -> Tasks -> Init/Shutdown Script -> ADD [Type=Script, Script*=z.B. /mnt/systempool/bin/prestart_usb.sh, When=Post Init]

##### 3. in der Jail ausführen:
- pkg update
- pkg install npm
- npm install -g --unsafe-perm node-red
- npm install pm2 -g
- pm2 start node-red
- pm2 save
- pm2 startup
- pm2 save
- npm i node-telegram-bot-api
- npm i socks5-https-client
   
##### 4. mit Hilfe von: https://forum.iobroker.net/topic/26058/sms-und-oder-anruf-mit-sim800-modul-und-node-red habe ich die kommenden Teile erstellt:

##### 5. die IP der Jail öffnen mit Poer 1880 und die 2 flows importieren (liegen auch hier):
- SetSettings ist um den Stick zu konfigurieren:
   - SIM800C Commands:   https://lastminuteengineers.com/sim800l-gsm-module-arduino-tutorial/
    - Configuring TEXT mode
     - AT+CMGF=1
    - Decides how newly arrived SMS messages should be handled
     - AT+CNMI=1,2,0,0,0
- ReceiveSMSsendtoTelegram macht was der Titel sagt 

### ACHTUNG: chatId und bottoken müssen noch eingegeben\geändert werden.



