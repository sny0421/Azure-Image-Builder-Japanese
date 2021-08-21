# Install windows language pack for Japanese
## Prepare secuence
### Define workspace path
$tempFolder = "C:\SIG_Temp"

## Download FOD file
### FOD file URL
$msContentUrl = "https://software-download.microsoft.com/download/pr/"
$fodFileName = "19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso"
$fodUrl = $msContentUrl + $fodFileName
### Local store path
$fodLocalPath = $tempFolder + '\' + $fodFileName

### Download
$wc = New-Object net.webclient
$wc.Downloadfile($fodUrl, $fodLocalPath)

## Install FOD files
### FOD file ISO mount 
Mount-DiskImage $fodLocalPath
$fodDriveLetter = (Get-DiskImage -ImagePath $fodLocalPath | Get-Volume).DriveLetter + ':'
### Install from ISO
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-Basic-ja-jp-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-Fonts-Jpan-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-Handwriting-ja-jp-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-OCR-ja-jp-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-Speech-ja-jp-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-LanguageFeatures-TextToSpeech-ja-jp-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~ja-jp~.cab
Add-WindowsPackage -Online -PackagePath $fodDriveLetter\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~ja-jp~.cab

## Unmount ISO
DisMount-DiskImage $fodLocalPath
