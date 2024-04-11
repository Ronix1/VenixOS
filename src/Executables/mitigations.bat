@echo off

:: disable process mitigations
PowerShell Set-ProcessMitigation -System -Disable CFG >nul 2>&1

:: get current mask
for /f "tokens=3 skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions"') do (
set "mitigation_mask=%%a"
) 

:: set all values in current mask to 2
for /L %%a in (0,1,9) do (
set "mitigation_mask=!mitigation_mask:%%a=2!"
) 

:: apply mask to kernel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul 2>&1
exit /b