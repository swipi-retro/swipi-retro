#!/usr/bin/python2.7
import RPi.GPIO as GPIO
import subprocess as SP
screenState = "/home/pi/swipi-retro/assets/currentDisplayMode"
GPIO.setmode(GPIO.BCM)

GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)

try:
    GPIO.wait_for_edge(23, GPIO.FALLING)
    stateFile = open(screenState, 'r')
    state = stateFile.readline()
    state = str(state)
    a,b = state.split("\n")
    state = a
    stateFile.close()
    if (state == "hdmi"):
	SP.call('echo "lcd" > /home/pi/swipi-retro/assets/currentDisplayMode', shell=True)
	SP.call(['sudo','/home/pi/swipi-retro/assets/lcd_out'])
	print("LCD-MODE")
    elif (state == "lcd"):
	SP.call('echo "hdmi" > /home/pi/swipi-retro/assets/currentDisplayMode', shell=True)
	SP.call(['sudo','/home/pi/swipi-retro/assets/hdmi_out'])
        print("HDMI-MODE")
except KeyboardInterrupt:
    GPIO.cleanup()       # clean up GPIO on CTRL+C exit
GPIO.cleanup()           # clean up GPIO on normal exit
