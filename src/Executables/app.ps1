$tempDir = Join-Path -Path $env:TEMP -ChildPath $([System.Guid]::NewGuid())
New-Item $tempDir -ItemType Directory -Force | Out-Null
Push-Location $tempDir

curl.exe -LSs "https://7-zip.org/a/7z2401-x64.exe" -o "$tempDir\7zip.exe"
curl.exe -LSs "https://aka.ms/vs/16/release/vc_redist.x64.exe" -o "$tempDir\c++.exe"
curl.exe -LSs "https://app.prntscr.com/build/setup-lightshot.exe" -o "$tempDir\ls.exe"


cmd /c "$tempDir\7zip.exe" /S
cmd /c "$tempDir\c++.exe" /q /norestart
cmd /c "$tempDir\ls.exe" /SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART