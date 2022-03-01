#!/bin/bash

sudo mkdir -p /data/rfparty/ble
sudo mkdir -p /data/rfparty/gps
sudo mkdir -p /data/rfparty/wifi
sudo mkdir -p /data/rfparty/logs


echo "setting monitor mode"
sudo airmon-ng start wlan1

echo "starting airodump"

sudo airodump-ng -w /data/rfparty/wifi/scan wlan1mon --gpsd &> /dev/null &

echo "starting blemonitor"

npm start --prefix /usr/lib/rfparty-monitor/ &> /data/rfparty/logs/ble-output.txt &

echo "starting gpsd logger"

sudo gpspipe -r -d -l -o /data/rfparty/gps/track.`date +"%Y%m%d%h%m%s"`.nmea &

echo "started 🤘🏿"
