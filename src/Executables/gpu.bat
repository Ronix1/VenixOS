@echo off
setlocal

:: detect gpu
set "gputype=Unknown"
for /f "tokens=*" %%i in ('wmic path win32_VideoController get name') do (
    echo %%i | findstr /C:"nvidia" > nul && set "gputype=nvidia" && goto :apply
    echo %%i | findstr /C:"amd" > nul && set "gputype=amd" && goto :apply
)

:apply
if "%gputype%"=="nvidia" (
    :: disable hdcp
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyGlobZero" /t REG_DWORD /d "1" /f  > nul 2>&1

    :: disable tcc
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f  > nul 2>&1

    :: disable tilted display
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableTiledDisplay" /t REG_DWORD /d "0" /f  > nul 2>&1

    :: remove nvidia telemetry
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f  > nul 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f  > nul 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f  > nul 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f  > nul 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f  > nul 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1
    schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"  > nul 2>&1

    :: disable nvidia power saving
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f  > nul 2>&1

    :: disable preemption
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidGfxPreemptionVGPU" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemptionForHighTdrTimeout" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableMidBufferPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableAsyncMidBufferPreemption" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f > nul 2>&1

    :: disable logging
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogWarningEntries" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogPagingEntries" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogEventEntries" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LogErrorEntries" /t REG_DWORD /d "0" /f > nul 2>&1

) else if "%gputype%"=="amd" (
    :: amd optimized settings
    reg add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 
    reg add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "WindowSize" /t REG_SZ /d "1440,960" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "LastPage" /t REG_SZ /d "settings/graphics/0/" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "SYSTEMTray" /t REG_SZ /d "false" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "CaptureFileOutput" /t REG_SZ /d "C:\Users\Emre\Videos\Radeon ReLive" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "AVCCaps" /t REG_SZ /d "256,1,4096,4096,100000000,244800,0;" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "HEVCCaps" /t REG_SZ /d "256,1,4096,4096,2147483647,979200,0;" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "AvcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "HevcEfcSupport" /t REG_SZ /d "0;" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "DvrDesktops" /t REG_SZ /d "\\.\DISPLAY19" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraSize" /t REG_DWORD /d "3" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraOpacity" /t REG_DWORD /d "100" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraAnchor" /t REG_DWORD /d "3" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraShownOnScreen" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "IndicatorPosition" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "TimerEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatCustomOffset" /t REG_SZ /d "0.0260,0.0462" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlayAnchor" /t REG_DWORD /d "4" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatBackgroundBlur" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatFontSize" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "RelativeCoords" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraCustomOffset" /t REG_SZ /d "0.0208,0.0370" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "CameraCustomRect" /t REG_SZ /d "0.1667,0.2222" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatCustomRect" /t REG_SZ /d "0.1562,0.1562" /f > nul 2>&1
    reg add "HKCU\Software\AMD\SCENE\0" /v "ChatOverlaySize" /t REG_DWORD /d "3" /f > nul 2>&1
    reg add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SOFTWARE\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SOFTWARE\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureOpt" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TextureLod" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASE" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASD" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ASTT" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAlias" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoType" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasMapping_SET" /t REG_BINARY /d "3028303A302C313A3029203228303A322C313A3229203428303A342C313A3429203828303A382C313A382900" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiAliasSamples_SET" /t REG_BINARY /d "3020322034203800" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth_SET" /t REG_BINARY /d "3020313620323400" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_OGL_SET" /t REG_BINARY /d "3020312032203320342035203620372038203920313120313220313320313420313520313620313700" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_SET" /t REG_BINARY /d "31203220342036203820313620333220363400" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "HighQualityAF" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DisplayCrossfireLogo" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AppGpuId" /t REG_BINARY /d "300078003000310030003000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PowerState" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AntiStuttering" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TurboSync" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SurfaceFormatReplacements" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EQAA" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "MLF" /t REG_BINARY /d "3000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TruformMode_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCEnable" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "3to2Pulldown" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "MosquitoNoiseRemoval" /t REG_BINARY /d "350030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Deblocking" /t REG_BINARY /d "350030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DemoMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OverridePA" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicRange" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "BlueStretch" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "LRTCCoef" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "DynamicContrast_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "WhiteBalanceCorrection" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Fleshtone" /t REG_BINARY /d "350030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance_ENABLE" /t REG_BINARY /d "31000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "ColorVibrance" /t REG_BINARY /d "340030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Detail" /t REG_BINARY /d "310030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise_ENABLE" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "Denoise" /t REG_BINARY /d "360034000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "TrueWhite" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "OvlTheaterMode" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "StaticGamma" /t REG_BINARY /d "3100300030000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD\DXVA" /v "InternetVideo" /t REG_BINARY /d "30000000" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDMACopy" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1

    :: debloat drivers
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\facebook" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\ffmpeg" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\Gfycat" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\localisation" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\mixer" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\models" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtCharts" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtMultimedia" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtQml" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtTest" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWebEngine" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWinExtras" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\quanminTV" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\resources" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\restream" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\sinaWeibo" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\streamable" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\translations" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\twitch" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\twitter" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\youku" > nul 2>&1
    rmdir /s /q "%PROGRAMFILES%\AMD\CNext\CNext\youtube" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\RadeonML-DirectML.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\swresample-3.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\swscale-5.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\WirelessVR-windesktop64.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\xerces-c_2_6.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding.bmp" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\brandingRSX.bmp" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\brandingWS_RSX.bmp" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\atiacmLocalisation.ini" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\radeonimagefilters64.dl_" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\radeonml-directml.dl_" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\ModularMonet.dtd" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding_pro_rsx.ico" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\branding_rsx.ico" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\CNVersions.json" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\workstation.rcc" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\amddvr.reg" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\EyefinityPro.reg" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\license.txt" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\ModularMonet.xml" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartCN.xml" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartCNBM.xml" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\StartDVR.xml" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\wProfile.xsd" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\7z.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\amddmlfilters.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\amdow.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\AMDRSServ.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\AMDRSSrcExt.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\ATISetup.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\AutoOverClockGFXCLK.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\CompressionUtility.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\DuplicateDesktop.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\EyefinityPro.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\gpuup.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\installShell64.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\MMLoadDrv.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\MMLoadDrvPXDiscrete.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\QtWebEngineProcess.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\RSServCmd.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\videotrim.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\ZipUtility.exe" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\7z.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\amf-component-ffmpeg64.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\amf-component-ring-buffer64.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avcodec-58.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avdevice-58.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avfilter-7.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avformat-58.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avresample-4.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\avutil-56.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\D3Dcompiler_47.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_cs.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_da_DK.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_de.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_el_GR.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_en_US.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_es_ES.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_fi_FI.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_fr_FR.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_hu_HU.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_it_IT.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ja.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ko_KR.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_nl_NL.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_no.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_pl.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_pt_BR.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_ru_RU.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_sv_SE.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_th.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_tr_TR.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_zh_CN.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\dvrres_zh_TW.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\freeglut.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\glew32.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\MediaInfo.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5Multimedia.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5MultimediaQuick.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5QuickTest.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5SerialPort.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5Test.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\Qt5WebEngineWidgets.dll" > nul 2>&1
    del /q "%PROGRAMFILES%\AMD\CNext\CNext\RadeonImageFilters64.dll" > nul 2>&1
exit /b
) else (
    exit /b
)

