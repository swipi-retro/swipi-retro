#include "Arduino.h"
#include <Adafruit_INA260.h>

// Pins
const int powerButtonPin = 33;
const int mcuEnPin = 32; // for 3v3 boost
const int mainEnPin = 2; // for pi and screen

// Inits
int lastButtonState = LOW;
int clickStartedMillis = 0;
boolean isInSoftShutdown = false;
boolean isInForcedShutdown = false;
Adafruit_INA260 ina260 = Adafruit_INA260(); // Voltage/Current/Power monitor

void setup() {
  // Serial with usb
  Serial.begin(115200);

  // Assign powerButtonPin as input
  pinMode(powerButtonPin, INPUT);

  // Keep mcu running by enabling 3.3v regulator
  pinMode(mcuEnPin, OUTPUT);
  digitalWrite(mcuEnPin, HIGH);

  // Start pi by enabling 5v regulators
  pinMode(mainEnPin, OUTPUT);
  digitalWrite(mainEnPin, HIGH);
}

void loop() {
  // Getting the button-state
  int buttonState = digitalRead(powerButtonPin);

  // Listening for button changes
  if (buttonState != lastButtonState) {
    if (buttonState == HIGH){ // Button was just pressed
      Serial.println("power-button pressed");
      clickStartedMillis = millis();
      lastButtonState = HIGH;
    }
    else { // // Button was just released
      Serial.println("power-button released");
      lastButtonState = LOW;
      clickStartedMillis = 0;

      // If the 5v regulator was disabled (isInForcedShutdown == true), we want to disable the mcu immediately after the button is released
      if (isInForcedShutdown){
        Serial.println("power-button released after forced shutdown was detected, disabling 3.3v regulator");
        delay(200);
        digitalWrite(mcuEnPin, LOW); // kill mcu
      }
    }
  }

  // Logic for forced shutdown when holding button
  if (!isInForcedShutdown && clickStartedMillis > 0){
    int buttonPressedMs = millis() - clickStartedMillis;

    if (buttonPressedMs > 3000) {
      Serial.println("forced shutdown detected, disabling 5v regulator");
      digitalWrite(mainEnPin, LOW);
      isInForcedShutdown = true;
    }
  }



  


    
//    // Power readings
//    Serial.print("Current: ");
//    Serial.print(ina260.readCurrent());
//    Serial.println(" mA");
//  
//    Serial.print("Bus Voltage: ");
//    Serial.print(ina260.readBusVoltage());
//    Serial.println(" mV");
//  
//    Serial.print("Power: ");
//    Serial.print(ina260.readPower());
//    Serial.println(" mW");
    

    /*if (isInShutdown == true){
      int shutdownState = digitalRead(shutdownNotificationReceiverPin);

      if (shutdownState == LOW) {
        // Blink three times
        digitalWrite(ledPin, HIGH);
        delay(400);
        digitalWrite(ledPin, LOW);
        delay(400);
        digitalWrite(ledPin, HIGH);
        delay(400);
        digitalWrite(ledPin, LOW);
        delay(400);
        digitalWrite(ledPin, HIGH);
        delay(400);
        digitalWrite(ledPin, LOW);
  
        // Additional time needed for the pi to properly shutdown
        delay(6500);
  
        // Cut power
        analogWrite(powerCutPin, 1023);
      }
    }*/
}
