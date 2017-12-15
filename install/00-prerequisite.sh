#!/bin/sh

sudo chmod 700 /home/pi/swipi-retro/assets/*
cd /home/pi/swipi-retro/assets/
sudo mv 00-screenHandlerDisplayModeRunner.sh /etc/profile.d/00-screenHandlerDisplayModeRunner.sh
sudo mv 00-screenHandlerJcDriverRunner.sh /etc/profile.d/00-screenHandlerJcDriverRunner.sh
sudo mv 00-screenHandlerPowerStateOnIndicatorRunner.sh /etc/profile.d/00-screenHandlerPowerStateOnIndicatorRunner.sh
sudo mv 00-screenHandlerShutdownListenerRunner.sh /etc/profile.d/00-screenHandlerShutdownListenerRunner.sh

