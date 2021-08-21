## Temporary working folder
$tempFolder = "C:\SIG_Temp"
$wc = New-Object net.webclient

# Visual Studio Code
$vsCodeUrl = "https://go.microsoft.com/fwlink/?Linkid=852157"
$vsCodeLocalPath = $tempFolder + "\vsCode.exe"
$wc.Downloadfile($vsCodeUrl, $vsCodeLocalPath)
Start-Process -FilePath $vsCodeLocalPath -ArgumentList "/VERYSILENT /MERGETASKS=!runcode" -Wait
