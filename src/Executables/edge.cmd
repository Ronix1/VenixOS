@echo off

REM Grant administrators full control over the Microsoft Edge folder
icacls "C:\Program Files (x86)\Microsoft\Edge" /t /c /q /grant administrators:F

REM Take ownership of the Microsoft Edge folder
takeown /f "C:\Program Files (x86)\Microsoft\Edge" /r /d y

REM Terminate Microsoft Edge processes
taskkill /f /im msedge.exe

REM Uninstall Microsoft Edge using the setup tool
cd "%PROGRAMFILES(X86)%\Microsoft\Edge\Application"
for /d %%I in (*) do (
    cd "%%I\Installer"
    setup --uninstall --force-uninstall --system-level
    cd ..
)

REM Remove Microsoft Edge folders
cd "%PROGRAMFILES(X86)%\Microsoft\Edge"
rmdir /s /q "C:\Program Files (x86)\Microsoft\Edge"