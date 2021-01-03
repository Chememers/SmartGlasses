#include <SPI.h>
#include <Wire.h>
#include <TimeLib.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

Adafruit_SSD1306 display = Adafruit_SSD1306(128, 32, &Wire);
String days[] = {"Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"};
String months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

// OLED FeatherWing buttons map to different pins depending on board:
#if defined(ESP8266)
  #define BUTTON_A  0
  #define BUTTON_B 16
  #define BUTTON_C  2
#elif defined(ESP32)
  #define BUTTON_A 15
  #define BUTTON_B 32
  #define BUTTON_C 14
#elif defined(ARDUINO_STM32_FEATHER)
  #define BUTTON_A PA15
  #define BUTTON_B PC7
  #define BUTTON_C PC5
#elif defined(TEENSYDUINO)
  #define BUTTON_A  4
  #define BUTTON_B  3
  #define BUTTON_C  8
#elif defined(ARDUINO_FEATHER52832)
  #define BUTTON_A 31
  #define BUTTON_B 30
  #define BUTTON_C 27
#else // 32u4, M0, M4, nrf52840 and 328p
  #define BUTTON_A  9
  #define BUTTON_B  6
  #define BUTTON_C  5
#endif

void setup() {
  Serial.begin(9600);
  Serial.println("Connecting to Smart Glasses ...");
  setTime(1,31,25,30,12,2020); //Will need to set the time manually for now
  //Serial.println(month());
  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C); // Address 0x3C for 128x64 OLED

  Serial.println("OLED began");
  display.display();
  delay(2000);

  // Clear the buffer.
  display.clearDisplay();
  display.display();
  String text = "Connected to glasses";

  showText(text, 1);
}

void showText(String& text, double fontSize){
  display.clearDisplay();
  display.setTextSize(fontSize);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);
  display.println(text);
  display.display();
}

void showTime(){
  display.clearDisplay();
  display.setTextSize(1);
  time_t t = now(); // store the current time in time variable t
  display.setCursor(30, 0);
  display.print(days[weekday(t) - 1]); display.print(", ");
  display.print(months[month(t) - 1]); display.print(" ");
  display.print(day(t));
  display.setTextSize(2);
  display.setCursor(12,15);
  display.print(hourFormat12(t)); 
  int sec = second(t);
  if (sec % 2 == 0){display.print(":");}
  else{display.print(" ");}
  display.print(minute(t)); display.print(" ");
  //display.print(second(t)); display.print(" ");
  if (isAM(t)){display.print("AM");}
  else {display.print("PM");}
  display.display();
}

void loop() {
    showTime(); 
    if (Serial.available() > 0){
      String in = Serial.readString();
      showText(in, 2);
      delay(5000);
    }
}