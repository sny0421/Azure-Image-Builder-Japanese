# Install Office ProPlus
$tempFolder = "C:\SIG_Temp"
## Download Office Deployment Tool (ODT)
$OdtUrl = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_12827-20268.exe"
$OdtLocalPath = $tempFolder + "\Odt.exe"
$wc = New-Object net.webclient
$wc.Downloadfile($OdtUrl, $OdtLocalPath)

## Deploy ODT
Start-Process -FilePath $OdtLocalPath -Wait -ArgumentList "/extract:$tempFolder /quiet"

## Install Office ProPlus
$OfficeLocalPath = $tempFolder + "\setup.exe"
$OfficeConfigPath = $tempFolder + "\configure.xml"
Start-Process -FilePath $OfficeLocalPath -Wait -ArgumentList "/configure $OfficeConfigPath"

### Mount the default user registry hive
REG LOAD HKU\TempDefault C:\Users\Default\NTUSER.DAT
### Must be executed with default registry hive mounted.
REG ADD HKU\TempDefault\SOFTWARE\Policies\Microsoft\office\16.0\common /v InsiderSlabBehavior /t REG_DWORD /d 2 /f
### Set Outlook's Cached Exchange Mode behavior
### Must be executed with default registry hive mounted.
REG ADD "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v enable /t REG_DWORD /d 1 /f
REG ADD "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v syncwindowsetting /t REG_DWORD /d 1 /f
REG ADD "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSetting /t REG_DWORD /d 1 /f
REG ADD "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSettingMonths  /t REG_DWORD /d 1 /f
### Unmount the default user registry hive
REG unload HKU\TempDefault

#### Set the Office Update UI behavior
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate" /v hideupdatenotifications /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate" /v hideenabledisableupdates /t REG_DWORD /d 1 /f

# Install OneDrive
## Download
$odUrl = "https://aka.ms/OneDriveWVD-Installer"
$odFileName = "\OneDriveSetup.exe"
$odLocalPath = $tempFolder + $odFileName
$wc = New-Object net.webclient
$wc.Downloadfile($odUrl, $odLocalPath)
## Uninstall exist OneDrive
Start-Process -FilePath $odLocalPath -ArgumentList "/uninstall" -Wait

## Enable AllUser Mode
REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64
## Install OneDrive
Start-Process -FilePath $odLocalPath -ArgumentList "/allusers"
## Set OneDrive behavior
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe /background" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f
