#!/bin/sh
controlflag=0
while :
do
deviceList=$(bt-device -l)
mac1=$(echo $deviceList | cut -b 29-45)
mac2=$(echo $deviceList | cut -b 61-77)
echo $mac1
links=$(bt-device -i $mac1)
rechts=$(bt-device -i $mac2)
connectedL=$(echo $links | cut -d ':' -f20)
connectedR=$(echo $rechts | cut -d ':' -f20)
finalL=$(echo $connectedL | cut -d ' ' -f1)
finalR=$(echo $connectedR | cut -d ' ' -f1)
if [ $finalL -eq 1 ] && [ $controlflag -eq 0 ] && [ $finalR -eq 1 ]
then
controlflag=$(($controlflag + 1 ))
sudo screen -dmS jcDriver jcdriver 
fi
sleep 0.2

done
