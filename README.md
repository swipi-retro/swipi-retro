__NOTE: This project is still in early development! It should be beta-ready in Q1 or Q2 2018.__

# swipi retro
A retropie based handheld gameconsole using joycons as controllers.

## Introduction
We decided to build a retropie handheld. After carefully looking at all the options that are existing out there, we decided we are going to do something on our own, going a different route, one may say. So "swipi retro" was born. Our requirements were that the swipi is easy to build AND easy to use.

To build one yourself you have simply to follow the tutorial below. First, you are going to build the hardware. After that, you only have to install the software and then, then you're golden. Start it, use it, have fun!

Disclaimer: We are absolute beginners in the field of CAD design and electrical engineering, so don't trust a word we say! We are using this project to gain and level up new skills.

## Partlist
* Raspberry Pi 3 Model B
* Official Raspberry Pi 7" Screen
* Nintendo Switch Joy-Cons
* Heatsinks
* Adafruit Trinket Pro 5V 16MHz
* Adafruit Powerboost 1000C

## Building the hardware

## Installation
* Install RetroPie on your SD-card
* Connect a keyboard to your Pi
* Start your Pi
* When prompted by RetroPie to configure the keyboard, press F4 (to get to the console)
* Simply execute the lines below (this will download this repository and do the complete installation).

```
sudo git clone https://github.com/swipi-retro/swipi-retro.git
sudo bash swipi-retro/install/00-prerequisite.sh
```

* After the installation has completed and the Pi has restarted, connect your joycons in RetroPie (the usual way of connecting a bluetooth controller to RetroPie). As soon as the second joycon is done connecting, the first led on both joycons should start blinking. This is the indication everything went well.
* Restart the system (this step is mandatory - without it, you won't be able to correctly connect your joycons)

Note: The installation will also create a default keyboard mapping for RetroPie.
## How to use it?
* Start the system
* Turn on both joycons (by pressing any button on the joycon)

The joycons are automatically connected to the Pi (since we set them up with RetroPie earlier). As soon as they both are connected, both joycons should have one led blinking.

Now you have to select if you want to use them both combined (1 player) or if you want them separately connected (2 players).

__1 Player__
* Press ZL and ZR at the same time. The bigger Joy-Con 1 shoulder key is ZL, the bigger Joy-Con 2 shoulder key is ZR. After doing that, the first led of both Joy-Cons should be permanently on (not blinking).

__2 Player__
* Simultanely press SL and SR on the first Joy-Con (led 1 should light permanentely). Then simultanely press SL and SR on the second Joy-Con (light 1 AND 2 should light permanently). SL and SR are the small keys on the side of the Joy-Cons (where the leds are too).

__Done__
Congratulations, you now can start playing. You don't have to map the Joy-Cons in RetroPie (we've already done that for you).

## Acknowledgements
* Rotter, for making the entry to CAD-software as easy as it gets
* [Riking](https://github.com/riking/joycon), for making a joycon driver
* [Drew Wallace](https://github.com/drew-wallace/switchberry), for the nice project
