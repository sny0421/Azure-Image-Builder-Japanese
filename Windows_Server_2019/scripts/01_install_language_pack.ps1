# Download language pack for Windows Server 2019
## Define download environment variables
### Temporary working folder
$tempFolder = "C:\Temp"
New-Item -Name $tempFolder -ItemType Directory
### Download path 
$lpkLocalPath = $tempFolder + "\LanguagePack.iso"
### Language pack URL
$lpkDownloadUrl = "https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVERLANGPACKDVD_OEM_MULTI.iso"
### Downlaod ISO file
$wc = New-Object net.webclient
$wc.Downloadfile($lpkDownloadUrl, $lpkLocalPath)

# Install language pack
## Language pack ISO mount
Mount-DiskImage $lpkLocalPath
## Get mounted disk letter
$driveLetter = (Get-DiskImage -ImagePath $downloadPath | Get-Volume).DriveLetter
$languagePackPath = $driveLetter + ":\x64\langpacks\Microsoft-Windows-Server-Language-Pack_x64_ja-jp.cab"
## install language pack
lpksetup.exe /i ja-JP /p $languagePackPath /r /s
Wait-Process -Name lpksetup

# Clean file
## Unmount disk
DisMount-DiskImage $lpkLocalPath
