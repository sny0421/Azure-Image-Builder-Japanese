# Overwrite UI language
Set-WinUILanguageOverride -Language ja-JP

# Set Time/Date format with same windows language
Set-WinCultureFromLanguageListOptOut -OptOut $False

# Set Location to Japan
Set-WinHomeLocation -GeoId 0x7A

# Set system locale to Japan
Set-WinSystemLocale -SystemLocale ja-JP

# Set timezone to Tokyo (JST)
Set-TimeZone -Id "Tokyo Standard Time"

# Set culture to Japan
Set-Culture ja-JP

# Configute default user and system display language
$DefaultHKEY = "HKU\DEFAULT_USER"
$DefaultRegPath = "C:\Users\Default\NTUSER.DAT"
$tempFolder = "C:\Temp"
$defaultPath = $tempFolder + "\ja-JP-default.reg"
$welcomePath = $tempFolder + "\ja-JP-welcome.reg"

REG LOAD $DefaultHKEY $DefaultRegPath
REG IMPORT $defaultPath
REG UNLOAD $DefaultHKEY
REG IMPORT $welcomePath

# Update UWP Apps
Get-AppxPackage -AllUsers | Foreach-Object {Add-AppxPackage -Register "$($_.InstallLocation)\AppxManifest.xml" -DisableDevelopmentMode}
Get-AppxPackage | Foreach-Object {Add-AppxPackage -Register "$($_.InstallLocation)\AppxManifest.xml" -DisableDevelopmentMode}

Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod

Start-Sleep -s 600
