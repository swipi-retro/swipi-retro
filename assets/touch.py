#!/usr/bin/python3
# This file was derived from: https://github.com/drew-wallace/switchberry

import struct
import time
import math
import glob
from ft5406 import Touchscreen, TS_PRESS, TS_RELEASE, TS_MOVE
from math import floor
from subprocess import call
import rpi_backlight as bl

def read_and_emulate_mouse(event, touch):
    global startX
    global startY
    global startTime
    global shouldRun

    if event == TS_PRESS:
        (startX, startY) = touch.position
        startTime = time.time()

    (x, y) = touch.position
    (last_x, last_y) = touch.last_position

    movement = math.sqrt(pow(x - startX, 2) + pow(y - startY, 2))
	# top left: brightness
    if startX < 244 and startY < 140 and x <= 244:
        bl.set_brightness(x + 11)
		
    # bottom left: volume
    if startX < 244 and startY > 340 and x <= 244:
        call(["amixer", "cset", "numid=1", "--", str(floor(x/2.44)) + '%'])
	
    #top right: kill jcDriver
    if startX > 556 and startY < 140:
        if movement < 20 and event == TS_RELEASE and (time.time() - startTime) >= 2:
            call(["sudo", "screen", "-S", "*.jcDriver", "-X", "quit"])

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