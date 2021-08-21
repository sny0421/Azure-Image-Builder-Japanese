# Install Office ProPlus
$tempFolder = "C:\SIG_Temp"

# Install Optimized Teams
## Set WVD environment mode
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Teams" /v IsWVDEnvironment /t REG_DWORD /d 1 /f
## Install Teams & optimize module
### Visual Studio C++ redist
$vcUrl = "https://aka.ms/vs/16/release/vc_redist.x64.exe"
$vcLocalPath = $tempFolder + "\vc_redist.x64.exe"
$wc.Downloadfile($vcUrl, $vcLocalPath)
Start-Process -FilePath $vcLocalPath -ArgumentList "/quiet" -Wait
### Teams WebSocket
$webSocketUrl = "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4AQBt"
$webSocketLocalPath = $tempFolder + "\websocket.msi"
$wc.Downloadfile($webSocketUrl, $webSocketLocalPath)
Start-Process msiexec.exe -ArgumentList "/i $webSocketLocalPath /passive" -Wait 
### Teams
$teamsUrl = "https://statics.teams.cdn.office.net/production-windows-x64/1.3.00.21759/Teams_windows_x64.msi"
$teamsLocalPath = $tempFolder + "\Teams_windows_x64.msi"
$wc.Downloadfile($teamsUrl, $teamsLocalPath)
$teamsLogPath = $tempFolder + "\Teams_install.log"
Start-Process msiexec.exe -ArgumentList "/i $teamsLocalPath /l*v $teamsLogPath ALLUSER=1 /passive" -Wait
