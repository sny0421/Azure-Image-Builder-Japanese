New-Item -Path "C:\StartLayout" -ItemType Directory
Move-Item "C:\SIG_Temp\layout.xml" "C:\StartLayout\layout.xml"
# Set Start Layout
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer!LockedStartLayout HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "StartLayoutFile" /t REG_SZ /d "C:\StartLayout\layout.xml" /f
