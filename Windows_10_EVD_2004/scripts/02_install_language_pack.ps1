# Install windows language pack for Japanese
## Prepare secuence
### Define workspace path
$tempFolder = "C:\SIG_Temp"
### Disable delete unused language pack
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"
REG ADD "HKLM\Software\Policies\Microsoft\Control Panel\International" /v "BlockCleanupOfUnusedPreinstalled" /t REG_DWORD /d 1 /f

## Download language pack
### Language pack URL
$msContentUrl = "https://software-download.microsoft.com/download/pr/"
$lpkFileName = "19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso"
$lpkUrl = $msContentUrl + $lpkFileName
### Local store path
$lpkLocalPath = $tempFolder + '\' + $lpkFileName
### Download ISO file
$wc = New-Object net.webclient
$wc.Downloadfile($lpkUrl, $lpkLocalPath)

## Install language pack
### Language pack ISO mount
Mount-DiskImage $lpkLocalPath
$lpkDriveLetter = (Get-DiskImage -ImagePath $lpkLocalPath | Get-Volume).DriveLetter + ':'

### Install from ISO
$lpkCabPath = $lpkDriveLetter + '\x64\langpacks'
$lpkAppxPath = $lpkDriveLetter + '\LocalExperiencePack\ja-jp'
Add-AppProvisionedPackage -Online -PackagePath $lpkAppxPath\LanguageExperiencePack.ja-jp.Neutral.appx -LicensePath $lpkAppxPath\License.xml
Add-WindowsPackage -Online -PackagePath $lpkCabPath\Microsoft-Windows-Client-Language-Pack_x64_ja-jp.cab

## Unmount ISO
DisMount-DiskImage $lpkLocalPath
