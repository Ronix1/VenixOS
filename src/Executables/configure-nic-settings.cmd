@echo off

for /f "tokens=3*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards" /k /v /f "Description" /s /e ^| findstr /ri "REG_SZ"') do (
    for /f %%g in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%%b" /d ^| findstr /C:"HKEY"') do (
    if not exist "%SYSTEMDRIVE%\Backup\(Default) %%b.reg" reg export "%%g" "%SYSTEMDRIVE%\Backup\(Default) %%b.reg" /y

    REM Disable Wake Features
    reg add "%%g" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*WakeOnPattern" /t REG_SZ /d "0" /f
    reg add "%%g" /v "WakeOnLink" /t REG_SZ /d "0" /f
    reg add "%%g" /v "S5WakeOnLan" /t REG_SZ /d "0" /f
    reg add "%%g" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f
    reg add "%%g" /v "*ModernStandbyWoLMagicPacket	" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f

    REM Disable Power Saving Features
    reg add "%%g" /v "*NicAutoPowerSaver" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*FlowControl" /t REG_SZ /d "0" /f
    reg add "%%g" /v "*EEE" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnablePME" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f
    reg add "%%g" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f
    reg add "%%g" /v "PowerSavingMode" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f
    reg add "%%g" /v "ULPMode" /t REG_SZ /d "0" /f
    reg add "%%g" /v "GigaLite" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableSavePowerNow" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnablePowerManagement" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableDynamicPowerGating" /t REG_SZ /d "0" /f
    reg add "%%g" /v "EnableConnectedPowerGating" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AutoDisableGigabit" /t REG_SZ /d "0" /f
    reg add "%%g" /v "AdvancedEEE" /t REG_SZ /d "0" /f
    reg add "%%g" /v "PowerDownPll" /t REG_SZ /d "0" /f
    reg add "%%g" /v "S5NicKeepOverrideMacAddrV2" /t REG_SZ /d "0" /f
    reg add "%%g" /v "MIMOPowerSaveMode" /t REG_SZ /d "3" /f
    reg add "%%g" /v "AlternateSemaphoreDelay" /t REG_SZ /d "0" /f

    REM Disable JumboPacket
    reg add "%%g" /v "JumboPacket" /t REG_SZ /d "0" /f

    REM Interrupt Moderation Adaptive (Default)
    reg add "%%g" /v "ITR" /t REG_SZ /d "125" /f

    REM Receive/Transmit Buffers
    reg add "%%g" /v "ReceiveBuffers" /t REG_SZ /d "266" /f
    reg add "%%g" /v "TransmitBuffers" /t REG_SZ /d "266" /f

    REM Enable Throughput Booster
    reg add "%%g" /v "ThroughputBoosterEnabled" /t REG_SZ /d "1" /f

    REM PnPCapabilities
    reg add "%%g" /v "PnPCapabilities" /t REG_DWORD /d "24" /f

    REM Enable LargeSendOffloads
    reg add "%%g" /v "LsoV1IPv4" /t REG_SZ /d "1" /f
    reg add "%%g" /v "LsoV2IPv4" /t REG_SZ /d "1" /f
    reg add "%%g" /v "LsoV2IPv6" /t REG_SZ /d "1" /f

    ::Enable Offloads
    reg add "%%g" /v "TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPsecOffloadV1IPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "IPsecOffloadV2" /t REG_SZ /d "3" /f
    reg add "%%g" /v "*IPsecOffloadV2IPv4" /t REG_SZ /d "3" /f
    reg add "%%g" /v "*PMARPOffload" /t REG_SZ /d "1" /f
    reg add "%%g" /v "*PMNSOffload" /t REG_SZ /d "1" /f
    reg add "%%g" /v "*PMWiFiRekeyOffload" /t REG_SZ /d "1" /f
    ) >nul 2>&1
    )