#include "Arduino.h"

// Configuration
const int powerButtonPin = 12;
const int shutdownCommandSenderPin =  4;
const int shutdownNotificationReceiverPin =  8;
const int ledPin = 13;
const byte powerCutPin = A4;

// Initialize some values
boolean isInShutdown = false;
int lastButtonState = HIGH;
int clickStartedMillis = 0;

void setup() {
  // Pin modes
  pinMode(shutdownCommandSenderPin, OUTPUT);
  digitalWrite(shutdownCommandSenderPin, HIGH);
  pinMode(ledPin, OUTPUT);
  pinMode(powerButtonPin, INPUT);
  digitalWrite(powerButtonPin, HIGH); // Activate pull-up resistor
  pinMode(shutdownNotificationReceiverPin, INPUT);
  pinMode(powerCutPin, OUTPUT);
}

void loop() {
    int buttonState = digitalRead(powerButtonPin);

    if (buttonState != lastButtonState) {
      if (buttonState == LOW){ // Button was just pressed
        clickStartedMillis = millis();
        lastButtonState = LOW;
      }
      else { // // Button was just released
        int timePressed =millis() - clickStartedMillis;

        lastButtonState = HIGH;
        clickStartedMillis = 0;

        if (timePressed >= 1000 && timePressed < 3000) {
          digitalWrite(shutdownCommandSenderPin, LOW); // Send shutdown-command
          isInShutdown = true;
        }

        if (timePressed >= 3000) {
          // Cut power
          analogWrite(powerCutPin, 1023);
        }
      }
    }

    if (isInShutdown == true){
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
    }
}