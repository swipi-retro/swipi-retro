#!/usr/bin/python3
# This file was derived from: https://github.com/drew-wallace/switchberry

import struct
import os
import time
import math
import signal
import glob
import sys
from ft5406 import Touchscreen, TS_PRESS, TS_RELEASE, TS_MOVE
from math import floor
from subprocess import call
from subprocess import check_output
import subprocess as SP
import rpi_backlight as bl
screenState = "/home/pi/swipi-retro/assets/currentDisplayMode"
PNGVIEWPATH = "/home/pi/Mintybatterymonitor/Pngview/"
ICONPATH = "/home/pi/Mintybatterymonitor/icons"
brightLast = ""
layerList = []
def read_and_emulate_mouse(event, touch):
    global startX
    global startY
    global startTime
    global shouldRun
    global brightLast
    global killid
    global layerList
    if event == TS_RELEASE:
        os.system("sudo kill " + "$(ps aux | grep '[p]ngview' | awk '{print $2}')")
        layerList = []
    if event == TS_PRESS:
        (startX, startY) = touch.position
        startTime = time.time()

    (x, y) = touch.position
    (last_x, last_y) = touch.last_position

    movement = math.sqrt(pow(x - startX, 2) + pow(y - startY, 2))
    # top left: brightness
    if startX < 244 and startY < 140 and x <= 244:
        bl.set_brightness(x + 11)
        brightnessValue = x + 11
        brightnessPng = ""
        if brightnessValue >= 5 and brightnessValue < 29:
            brightnessPng = "10"
        elif brightnessValue >= 30 and brightnessValue < 54:
            brightnessPng = "20"
        elif brightnessValue >= 55 and brightnessValue < 79:
            brightnessPng = "30"
        elif brightnessValue >= 80 and brightnessValue < 104:
            brightnessPng = "40"
        elif brightnessValue >= 105 and brightnessValue < 129:
            brightnessPng = "50"
        elif brightnessValue >= 130 and brightnessValue < 154:
            brightnessPng = "60"
        elif brightnessValue >= 155 and brightnessValue < 179:
            brightnessPng = "70"
        elif brightnessValue >= 180 and brightnessValue < 204:
            brightnessPng = "80"        
        elif brightnessValue >= 205 and brightnessValue < 230:
            brightnessPng = "90"
        elif brightnessValue >= 231:
            brightnessPng = "100"
        if brightLast != brightnessPng and brightnessPng != "":
            brightLast = brightnessPng
            if len(layerList) == 0:
                os.system("/home/pi/swipi-retro/assets/Pngview" + "/pngview -b 0 -l 3000" + "1" + " -x 260 -y 150 " + "/home/pi/swipi-retro/assets/icons/brightness/" + "bar" + ".png &")			
            os.system("/home/pi/swipi-retro/assets/Pngview" + "/pngview -b 0 -l 3000" + brightnessPng + " -x 260 -y 150 " + "/home/pi/swipi-retro/assets/icons/brightness/" + brightnessPng + ".png &")
            killBrightnessID = check_output("ps aux | grep '[p]ngview' | awk '{print $2}'", shell=True)
            killBrightnessID = killBrightnessID.decode("utf-8")
            killBrightnessID = killBrightnessID.replace("\n", " ")
            killBrightnessID = killBrightnessID.split(" ")
            for layer in killBrightnessID:
                if layer != "" and layer not in layerList:
                    layerList.append(layer)
            if len(layerList) == 3:
                killThisID = str(layerList[1])
                os.system("sudo kill " + killThisID)
                layerList.remove(layerList[1])
    # bottom left: volume
    if startX < 244 and startY > 340 and x <= 244:
        call(["amixer", "cset", "numid=1", "--", str(floor(x/2.44)) + '%'])
    
    #top right: kill jcDriver
    if startX > 556 and startY < 140:
        if movement < 20 and event == TS_RELEASE and (time.time() - startTime) >= 2:
            call(["sudo", "screen", "-S", "jcDriver", "-X", "quit"])
            call(["sudo", "screen", "-dmSL", "jcDriver", "jcdriver"])
    #bottom right: switch Displaymode
    if startX > 556 and startY > 340:
        if movement < 20 and event == TS_RELEASE and (time.time() - startTime) >= 2:
            stateFile = open(screenState, 'r')
            state = stateFile.readline()
            state = str(state)
            stateFile.close()
            if (state == "lcd"):
                SP.call('echo "hdmi" > /home/pi/swipi-retro/assets/currentDisplayMode', shell=True)
                SP.call(['sudo','/home/pi/swipi-retro/assets/hdmi_out'])
            else :
                SP.call('echo "lcd" > /home/pi/swipi-retro/assets/currentDisplayMode', shell=True)
                SP.call(['sudo','/home/pi/swipi-retro/assets/lcd_out'])


if __name__ == "__main__":
    global shouldRun
    shouldRun = True
    ts = Touchscreen()

    for touch in ts.touches:
        touch.on_press = read_and_emulate_mouse
        touch.on_release = read_and_emulate_mouse
        touch.on_move = read_and_emulate_mouse

    ts.run()

    while shouldRun:
        try:
            time.sleep(1)
        except KeyboardInterrupt:
            ts.stop()
            exit()

    ts.stop()
    exit()