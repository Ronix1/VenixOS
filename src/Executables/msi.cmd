@echo off
setlocal EnableDelayedExpansion
set "val=valorant valorant-win64-shipping vgtray vgc"
PowerShell -NoP -C "foreach ($a in $($env:val -split ' ')) {Set-ProcessMitigation -Name $a`.exe -Enable CFG}" > nul
for %%a in ("CIM_NetworkAdapter", "CIM_USBController", "CIM_VideoController" "Win32_IDEController", "Win32_PnPEntity", "Win32_SoundDevice") do (
    if "%%~a" == "Win32_PnPEntity" (
        for /f "tokens=*" %%b in ('PowerShell -NoP -C "Get-WmiObject -Class Win32_PnPEntity | Where-Object {($_.PNPClass -eq 'SCSIAdapter') -or ($_.Caption -like '*High Definition Audio*')} | Where-Object { $_.PNPDeviceID -like 'PCI\VEN_*' } | Select-Object -ExpandProperty DeviceID"') do (
            reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%b\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f > nul
            reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%b\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f > nul 2>&1
        )
    ) else (
        for /f %%b in ('wmic path %%a get PNPDeviceID ^| findstr /l "PCI\VEN_"') do (
            reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%b\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f > nul
            reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%b\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f > nul 2>&1
        )
    )
)
for /f %%a in ('wmic PATH Win32_PnPEntity GET DeviceID ^| findstr /l "USB\VID_"') do (
    C:\Windows\SetACL.exe -on "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" -ot reg -actn setowner -ownr "n:Administrators"
    C:\Windows\SetACL.exe -on "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" -ot reg -actn ace -ace "n:Administrators;p:full"
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /v SelectiveSuspendOn /t REG_DWORD /d 00000000 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /v SelectiveSuspendEnabled /t REG_BINARY /d 00 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 00000000 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 00000000 /f
)
for /f %%a in ('wmic PATH Win32_USBHub GET DeviceID ^| findstr /l "USB\ROOT_HUB"') do (
    C:\Windows\SetACL.exe -on "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters\WDF" -ot reg -actn setowner -ownr "n:Administrators"
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 00000000 /f
)
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set "mem=%%i"
$dv = @(
	"AMD PSP",
	"AMD SMBus",
	"Base System Device",
	"Composite Bus Enumerator",
	"Direct memory access controller"
	"High precision event timer",
	"Intel Management Engine",
	"Intel SMBus",
	"Legacy device",
	"Microsoft Kernel Debug Network Adapter",
	"Motherboard resources",
	"Numeric Data Processor",
	"PCI Data Acquisition and Signal Processing Controller",
	"PCI Encryption/Decryption Controller",
	"PCI Memory Controller",
	"PCI Simple Communications Controller",
	"PCI standard RAM Controller",
	"SM Bus Controller",
	"System CMOS/real time clock",
	"System Speaker",
	"System Timer"
)
Get-PnpDevice -FriendlyName $dv -ErrorAction Ignore | Disable-PnpDevice -Confirm:$false -ErrorAction Ignore
exit