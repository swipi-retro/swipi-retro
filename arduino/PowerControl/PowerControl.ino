#include "Arduino.h"

// Configuration
const int powerButtonPin = 12;
const int shutdownCommandSenderPin =  4;
const int shutdownNotificationReceiverPin =  8;
const int ledPin = 13;
const byte powerCutPin = A4;

// Initialize some values
boolean isInShutdown = false;

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
  if (isInShutdown == false) {
    int buttonState = digitalRead(powerButtonPin);
  
    if (buttonState == LOW) {
      digitalWrite(shutdownCommandSenderPin, LOW); // Send shutdown-command
  
      // Blink twice 
      digitalWrite(ledPin, HIGH);
      delay(400);
      digitalWrite(ledPin, LOW);
      delay(400);
      digitalWrite(ledPin, HIGH);
      delay(400);
      digitalWrite(ledPin, LOW);
      
      isInShutdown = true;
    }
  }
  else {
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
