@echo off

:: set primary dns server to 1.1.1.1 
netsh interface ip set dns name="Ethernet" static 1.1.1.1 primary >nul 2>&1

:: set secondary dns server to 1.0.0.1
netsh interface ip add dns name="Ethernet" addr=1.0.0.1 index=2 >nul 2>&1