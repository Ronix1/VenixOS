$tempDir = Join-Path -Path $env:TEMP -ChildPath $([System.Guid]::NewGuid())
New-Item $tempDir -ItemType Directory -Force | Out-Null
Push-Location $tempDir

curl.exe -LSs "https://github.com/brave/brave-browser/releases/download/v1.63.174/BraveBrowserStandaloneSilentSetup.exe" -o "$tempDir\brave.exe"


cmd /c "$tempDir\brave.exe"