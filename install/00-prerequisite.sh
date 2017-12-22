#!/bin/sh

sudo chmod 755 /home/pi/swipi-retro/assets/*
cd /home/pi/swipi-retro/assets/
sudo mv 00-screenHandlerDisplayModeRunner.sh /etc/profile.d/00-screenHandlerDisplayModeRunner.sh
sudo mv 00-screenHandlerJcDriverRunner.sh /etc/profile.d/00-screenHandlerJcDriverRunner.sh
sudo mv 00-screenHandlerPowerStateOnIndicatorRunner.sh /etc/profile.d/00-screenHandlerPowerStateOnIndicatorRunner.sh
sudo mv 00-screenHandlerShutdownListenerRunner.sh /etc/profile.d/00-screenHandlerShutdownListenerRunner.sh
sudo mv jcdriver /usr/bin/jcdriver
#General configuration

echo "gpu_mem=128
audio_pwm_mode=2
display_default_lcd=1" | sudo tee -a /boot/config.txt
#Python

sudo apt-get install -y python-setuptools python-dev
sudo apt-get install -y python3 python3-pip
sudo easy_install rpi.gpio

cd ..
sudo mkdir git
cd git
git clone https://github.com/pimoroni/python-multitouch.git
cd python-multitouch/library
sudo python3 setup.py install
sudo pip3 install python-uinput pyudev rpi_backlight
#Install screen / bluez-tools
sudo apt-get install -y screen bluez-tools
#
cd /home/pi/swipi-retro/assets/
sudo mv retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
sudo mv "Full Joy-Con 1.cfg" "/opt/retropie/configs/all/retroarch/autoconfig/Full Joy-Con 1.cfg"
sudo mv "Full Joy-Con 1.cfg.bak" "/opt/retropie/configs/all/retroarch/autoconfig/Full Joy-Con 1.cfg.bak"
sudo mv "Half Joy-Con 1.cfg" "/opt/retropie/configs/all/retroarch/autoconfig/Half Joy-Con 1.cfg"
sudo mv "Half Joy-Con 1.cfg.bak" "/opt/retropie/configs/all/retroarch/autoconfig/Half Joy-Con 1.cfg.bak"
sudo mv "Half Joy-Con 2.cfg" "/opt/retropie/configs/all/retroarch/autoconfig/Half Joy-Con 2.cfg"
sudo mv "Half Joy-Con 2.cfg.bak" "/opt/retropie/configs/all/retroarch/autoconfig/Half Joy-Con 2.cfg.bak"
sudo mv "Joy-Con(L).cfg" "/opt/retropie/configs/all/retroarch/autoconfig/Joy-Con(L).cfg"
sudo mv "Joy-Con(R).cfg" "/opt/retropie/configs/all/retroarch/autoconfig/Joy-Con(R).cfg"
sudo mv "es_input.cfg" "/opt/retropie/configs/all/emulationstation/es_input.cfg"
sudo mv "es_temporaryinput.cfg" "/opt/retropie/configs/all/emulationstation/es_temporaryinput.cfg"

