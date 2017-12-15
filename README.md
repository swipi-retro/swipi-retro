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
Simply execute the lines below on your RetroPie (this will download this repository and do the complete installation).

```
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y git
sudo mkdir swipi-retro
cd swipi-retro
sudo git clone https://github.com/swipi-retro/swipi-retro.git
sudo bash 00-prerequisite.sh
```

## How to use it?

## Acknowledgements
* Rotter, for making the entry to CAD-software as easy as it gets
