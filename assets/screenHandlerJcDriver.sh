#!/bin/sh
controlflag=0
while :
do
links=$(bt-device -i 04:03:D6:BA:81:5C)
rechts=$(bt-device -i 04:03:D6:B9:DB:FA)
connectedL=$(echo $links | cut -d ':' -f20)
connectedR=$(echo $rechts | cut -d ':' -f20)
finalL=$(echo $connectedL | cut -d ' ' -f1)
finalR=$(echo $connectedR | cut -d ' ' -f1)
if [ $finalL -eq 1 ] && [ $controlflag -eq 0 ] && [ $finalR -eq 1 ]
then
controlflag=$(($controlflag + 1 ))
sudo screen -dmSL jcDriver jcdriver 
fi
sleep 0.2

done
