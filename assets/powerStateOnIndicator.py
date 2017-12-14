#!/usr/bin/python2.7
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)

GPIO.setup(24, GPIO.OUT, inital=GPIO.LOW)

GPIO.output(24, GPIO.HIGH)
