# Change display language to Japansese
Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force

# Change input method to Japanese
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

# Change MS-IME input bar
Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar
