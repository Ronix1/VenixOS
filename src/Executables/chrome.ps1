$tempDir = Join-Path -Path $env:TEMP -ChildPath $([System.Guid]::NewGuid())
New-Item $tempDir -ItemType Directory -Force | Out-Null
Push-Location $tempDir

curl.exe -LSs "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -o "$tempDir\chrome.exe"


cmd /c "$tempDir\chrome.exe" /silent /install