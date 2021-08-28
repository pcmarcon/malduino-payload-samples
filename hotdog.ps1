$userDesk = [Environment]::GetFolderPath("Desktop")
cd $userDesk
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/hotdog.bmp', 'hotdog.bmp')
start-sleep -s 5
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $userDesk/hotdog.bmp
1..20 | % { rundll32.exe user32.dll, UpdatePerUserSystemParameters }

