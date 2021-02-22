## Temporary working folder
$tempFolder = "C:\SIG_Temp"
$wc = New-Object net.webclient

# Chromium Edge
$edgeUrl = "http://dl.delivery.mp.microsoft.com/filestreamingservice/files/789ec525-0feb-4d62-a24b-99fd15d117e4/MicrosoftEdgeEnterpriseX64.msi"
$edgeLocalPath = $tempFolder + "\edge_install.exe"
$wc.Downloadfile($edgeUrl, $edgeLocalPath)
Start-Process msiexec.exe -ArgumentList "/i $edgeLocalPath /passive" -Wait
