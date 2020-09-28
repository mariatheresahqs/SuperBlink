#define DELAY 200
#define ON 0X01
#define OFF 0x00
#define NUM_LEDS 0X03

// bitfields where the colors are alocated
#define RED_LED 0x400000
#define BLUE_LED 0X200000
#define GREEN_LED 0X080000

void setupGPIO();
int setLED(int color, int state);
void delay(int milliseconds);