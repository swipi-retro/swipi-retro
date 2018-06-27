#!/bin/sh

sudo apt-get update
sudo apt-get upgrade -y
sudo sh -c "echo 'avoid_warnings=1' >> /boot/config.txt"
sudo sh -c "echo 'disable_splash=1' >> /boot/config.txt"
sudo sh -c "echo 'dwc_otg.lpm_enable=0 console=serial0,115200 console=tty3 root=PARTUUID=5728b712-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait loglevel=3 consoleblank=0 plymouth.enable=0 logo.nologo vt.global_cursor_default=0' > /boot/cmdline.txt"
sudo sed -i 's/tty1/tty3/g' /boot/cmdline.txt
sudo chmod 755 /home/pi/swipi-retro/assets/*
sudo chown pi:pi /home/pi/swipi-retro
sudo chown pi:pi /home/pi/swipi-retro/*
cd /home/pi/swipi-retro/assets/
sudo mv 00-startup.sh /etc/init.d/00-startup.sh
sudo mv 01-screenHandlerDisplayModeRunner.sh /etc/init.d/01-screenHandlerDisplayModeRunner.sh
sudo mv 02-screenHandlerJcDriverRunner.sh /etc/init.d/02-screenHandlerJcDriverRunner.sh
sudo mv 03-screenHandlerPowerStateOnIndicatorRunner.sh /etc/init.d/03-screenHandlerPowerStateOnIndicatorRunner.sh
sudo mv 04-screenHandlerShutdownListenerRunner.sh /etc/init.d/04-screenHandlerShutdownListenerRunner.sh
sudo mv 05-screenHandlerTouchRunner.sh /etc/init.d/05-screenHandlerTouchRunner.sh
sudo update-rc.d 01-screenHandlerDisplayModeRunner.sh defaults
sudo update-rc.d 02-screenHandlerJcDriverRunner.sh defaults
sudo update-rc.d 03-screenHandlerPowerStateOnIndicatorRunner.sh defaults
sudo update-rc.d 04-screenHandlerShutdownListenerRunner.sh defaults
sudo update-rc.d 05-screenHandlerTouchRunner.sh defaults
sudo mv jcdriver /usr/bin/jcdriver
#General configuration

echo "gpu_mem=128
audio_pwm_mode=2
display_default_lcd=1" | sudo tee -a /boot/config.txt
#Python

sudo apt-get install -y python-setuptools python-dev
sudo apt-get install -y python3 python3-pip
#sudo pip3 install python-uinput pyudev rpi_backlight
sudo easy_install rpi.gpio
cd github-repos/pimoroni/python-multitouch/python-multitouch-master/library
sudo python3 setup.py install

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
sudo mv "es_input.cfg" "/opt/retropie/configs/all/emulationstation/es_input.cfg"
sudo mv "es_temporaryinput.cfg" "/opt/retropie/configs/all/emulationstation/es_temporaryinput.cfg"
sudo touch ~/.hushlogin
sudo mv "/home/pi/swipi-retro/assets/autologin@.service" "/etc/systemd/system/autologin@.service"
sudo mv "/home/pi/swipi-retro/assets/autostart.sh" "/opt/retropie/configs/all/autostart.sh"
sudo chmod 644 autostart.sh
print("Setup complete, going to reboot")
sudo reboot
