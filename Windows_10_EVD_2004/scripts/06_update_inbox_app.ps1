##Set Inbox App Package Content Stores##
$tempFolder = "C:\Temp"

### Language pack URL
$msContentUrl = "https://software-download.microsoft.com/download/pr/"
$ibaFileName = "19041.1.191206-1406.vb_release_amd64fre_InboxApps.iso"
$ibaUrl = $msContentUrl + $ibaFileName
$ibaLocalPath = $tempFolder + '\' + $ibaFileName
## Download
$wc = New-Object net.webclient
$wc.Downloadfile($ibaUrl, $ibaLocalPath)

Mount-DiskImage $ibaLocalPath
$ibaDriveLetter = (Get-DiskImage -ImagePath $ibaLocalPath | Get-Volume).DriveLetter + ':'
$ibaCabPath = $ibaDriveLetter + '\amd64fre'


## Update Inbox Store Apps
$allAppx = Get-Item $ibaCabPath\*.appx | Select-Object name
$allAppxBundles = Get-Item $ibaCabPath\*.appxbundle | Select-Object name
$allAppxXML = Get-Item $ibaCabPath\*.xml | Select-Object name
foreach ($appx in $allAppx) {
    $appname = $appx.name.substring(0,$appx.name.length-5)
    $appnamexml = $appname + ".xml"
    $pathappx = $ibaCabPath + "\" + $appx.Name
    $pathxml = $ibaCabPath + "\" + $appnamexml
    
    if($allAppxXML.name.Contains($appnamexml)){
    
    Write-Host "Handeling with xml $appname"  
  
    Add-AppxProvisionedPackage -Online -PackagePath $pathappx -LicensePath $pathxml
    } else {
      
      Write-Host "Handeling without xml $appname"
      
      Add-AppxProvisionedPackage -Online -PackagePath $pathappx -skiplicense
    }
}
foreach ($appx in $allAppxBundles) {
    $appname = $appx.name.substring(0,$appx.name.length-11)
    $appnamexml = $appname + ".xml"
    $pathappx = $ibaCabPath + "\" + $appx.Name
    $pathxml = $ibaCabPath + "\" + $appnamexml
    
    if($allAppxXML.name.Contains($appnamexml)){
    Write-Host "Handeling with xml $appname"
    
    Add-AppxProvisionedPackage -Online -PackagePath $pathappx -LicensePath $pathxml
    } else {
       Write-Host "Handeling without xml $appname"
      Add-AppxProvisionedPackage -Online -PackagePath $pathappx -skiplicense
    }
}
DisMount-DiskImage $ibaLocalPath

# Update UWP Apps
Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod

Start-Sleep -s 900

REG ADD "HKLM\Software\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f
#reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
gpupdate /force
