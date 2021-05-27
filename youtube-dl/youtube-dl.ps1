$url = Read-Host "URL"

youtube-dl.exe $url -F | Select-String -Pattern "webm"

Write-Output "`nSelect Format Code(s)"
$formatCodes = Read-Host "If you want to download multiple, concatenate format codes with '+'"

Push-Location $env:USERPROFILE/downloads
youtube-dl.exe $url -f $formatCodes
Pop-Location

Write-Output "Exit script."
Pause
