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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableTimeZoneRedirection /t REG_DWORD /d 1 /f

# Set culture to Japan
Set-Culture ja-JP
