$file = $ENV:LOCALAPPDATA + ‘\screen_enc.jpg’; 
(New-Object System.Net.WebClient).DownloadFile(‘https://raw.githubusercontent.com/pcmarcon/malduino-payload-samples/master/screen_enc.jpg', $file)
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type -AssemblyName 'System.Windows.Forms'
#$file = (get-item '\\192.168.1.127\Documents\ataque\screen.png')
$img = [System.Drawing.Image]::Fromfile((get-item $file))

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
