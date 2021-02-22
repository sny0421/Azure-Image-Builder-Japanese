# Disable Windows updates and store apps automatic update
## Disable Windows updates
REG ADD "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
## Disable store apps automatic update
REG ADD "HKLM\Software\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f
## Attempt Local GPO
gpupdate /force

# Add a firewall rule for remote management
netsh advfirewall firewall add rule name="Windows Remote Management (HTTP-In)" dir=in action=allow service=any enable=yes profile=any localport=5985 protocol=tcp
