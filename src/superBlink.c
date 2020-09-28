#include "superBlink.h"
#include <stdio.h>

int main() {

  int error = 0;
  int ledNum = 0;
  int colors[NUM_LEDS] = {GREEN_LED, RED_LED, BLUE_LED};

  setupGPIO();

  while (!error) {
    setLED(colors[ledNum], ON);
    delay(DELAY);
    error = setLED(colors[ledNum++], OFF);
    delay(DELAY);
    if (ledNum >= NUM_LEDS)
      ledNum = 0;
  }
}