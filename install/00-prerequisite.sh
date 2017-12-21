#!/bin/sh

sudo chmod 700 /home/pi/swipi-retro/assets/*
cd /home/pi/swipi-retro/assets/
sudo mv 00-screenHandlerDisplayModeRunner.sh /etc/profile.d/00-screenHandlerDisplayModeRunner.sh
sudo mv 00-screenHandlerJcDriverRunner.sh /etc/profile.d/00-screenHandlerJcDriverRunner.sh
sudo mv 00-screenHandlerPowerStateOnIndicatorRunner.sh /etc/profile.d/00-screenHandlerPowerStateOnIndicatorRunner.sh
sudo mv 00-screenHandlerShutdownListenerRunner.sh /etc/profile.d/00-screenHandlerShutdownListenerRunner.sh
#General configuration

echo "gpu_mem=128
audio_pwm_mode=2
display_default_lcd=1" | sudo tee -a /boot/config.txt
#Python

sudo apt-get install -y python-setuptools python-dev
sudo apt-get install -y python3 python3-pip
sudo easy_install rpi.gpio

cd..
sudo mkdir git
cd git
git clone https://github.com/pimoroni/python-multitouch.git
cd python-multitouch/library
sudo python3 setup.py install
sudo pip3 install python-uinput pyudev rpi_backlight
#Install screen
sudo apt-get install -y screen
#Create screen-switch-scripts
cd /home/pi/swipi-retro/assets/

