# malduino-payload-samples

just few samples to simulate ransomware atack using malduino to run these payloads

samples based on https://github.com/H0neyBadger/H0ney ransomware POC PowerShell

please take a look on H0neyBadger repository if you intent to decript files also....


Payload Sample Files
====================
single_file_enc.ps1 - will encrypt only the file test.txt on the current drive and show a fake screen asking for payment

single_file_enc.bat - list of commands that must be executed using malduino script

screen_enc.jpg - fake ransomware encryption image to display

single_file_enc_malduino.ino - arduino firmware with payload script for ORIGINAL MALDUINO HW

single_file_enc_generic.ino - arduino firmware with payload script for GENERIC USB ATMEGA32U4 HW

