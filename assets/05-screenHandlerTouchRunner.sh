#!/bin/sh
### BEGIN INIT INFO
# Provides: /etc/init.d/05-screenHandlerTouchRunner.sh
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Kurze Beschreibung
# Description: Lange Beschreibung
### END INIT INFO
sudo nohup /home/pi/swipi-retro/assets/screenHandlerTouch.sh &

sleep 1
