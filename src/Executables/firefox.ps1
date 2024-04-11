$tempDir = Join-Path -Path $env:TEMP -ChildPath $([System.Guid]::NewGuid())
New-Item $tempDir -ItemType Directory -Force | Out-Null
Push-Location $tempDir

curl.exe -LSs "https://download-installer.cdn.mozilla.net/pub/firefox/releases/123.0.1/win64/en-US/Firefox%20Setup%20123.0.1.msi" -o "$tempDir\firefox.exe"


cmd /c "$tempDir\firefox.exe" /s