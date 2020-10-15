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
