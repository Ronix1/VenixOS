@echo off
setlocal EnableDelayedExpansion

netsh int tcp set global autotuninglevel=normal
netsh interface 6to4 set state disabled
netsh int isatap set state disable
netsh int tcp set global timestamps=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set security mpp=disabled
netsh int tcp set security profiles=disabled
netsh int ip set global icmpredirects=disabled
netsh int tcp set security mpp=disabled profiles=disabled
netsh int ip set global multicastforwarding=disabled
netsh int tcp set supplemental internet congestionprovider=ctcp
netsh interface teredo set state disabled
netsh winsock reset
netsh int ip set global taskoffload=disabled
netsh int ip set global neighborcachelimit=4096
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
PowerShell Disable-NetAdapterLso -Name "*"
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterPowerManagement -Name $adapter.Name -ErrorAction SilentlyContinue}"
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterLso -Name $adapter.Name -ErrorAction SilentlyContinue}"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "LLInterface" /t REG_SZ /d "WANARP" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}\0Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}\0Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}\0Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "NumInterfaces" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\NdisWanIp" /v "IpInterfaces" /t REG_BINARY /d "268ed40d783d794194e1b985bd4464741e8b4db51492a64090ba39c6fc82e86b30983a82c95eb848b5efef5f087ebb7d14969a7483ecc34cb32bc3696b9aeeed" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "8760" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "8760" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "domme" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DataBasePath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\drivers\etc" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NameServer" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ForwardBroadcasts" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "IPEnableRouter" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Domain" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Hostname" /t REG_SZ /d "domme" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SearchList" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "UseDomainNameDevolution" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableSecurityFilters" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\localstrike.net\ads" /v "*" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\localstrike.net\search" /v "*" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LLInterface" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /v "LLInterface" /t REG_SZ /d "ARP1394" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{B2C8C55E-653D-4C97-AADB-6DE6FB94AC89}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{E686FBA4-2E2C-4855-9035-0C70B85184B6}" /v "LLInterface" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{E686FBA4-2E2C-4855-9035-0C70B85184B6}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{E686FBA4-2E2C-4855-9035-0C70B85184B6}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DNSRegisteredAdapters" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{20612573-D9EB-46BB-9D1D-EED00C62A620}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAddress" /t REG_MULTI_SZ /d "192.168.0.2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "SubnetMask" /t REG_MULTI_SZ /d "255.255.255.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DefaultGateway" /t REG_MULTI_SZ /d "192.168.0.1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DefaultGatewayMetric" /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "NameServer" /t REG_SZ /d "192.168.0.1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "Domain" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RegistrationEnabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RegisterAdapterName" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "TCPAllowedPorts" /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "UDPAllowedPorts" /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "RawIPAllowedProtocols" /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "NTEContextList" /t REG_MULTI_SZ /d "0x00000002" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DhcpClassIdBin" /t REG_BINARY /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "DhcpServer" /t REG_SZ /d "255.255.255.255" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "Lease" /t REG_DWORD /d "3600" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LeaseObtainedTime" /t REG_DWORD /d "1128721584" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "T1" /t REG_DWORD /d "1128723384" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "T2" /t REG_DWORD /d "1128724734" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "LeaseTerminatesTime" /t REG_DWORD /d "1128725184" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationAddress" /t REG_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationMask" /t REG_SZ /d "255.255.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "IPAutoconfigurationSeed" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8DFEEA2-1FBA-427A-8639-668BFC4F78B0}" /v "AddressType" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "LLInterface" /t REG_SZ /d "ARP1394" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "LLInterface" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "IpConfig" /t REG_MULTI_SZ /d "Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{0DD48E26-3D78-4179-94E1-B985BD446474}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{749A9614-EC83-4CC3-B32B-C3696B9AEEED}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{823A9830-5EC9-48B8-B5EF-EF5F087EBB7D}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "EnableDHCP" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "DefaultGatewayMetric" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "NameServer" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "Domain" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "RegistrationEnabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{9A2FF573-9392-4328-A76E-3CC5A195D9E2}" /v "RegisterAdapterName" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "IPAddress" /t REG_MULTI_SZ /d "192.168.0.1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "SubnetMask" /t REG_MULTI_SZ /d "255.255.255.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "DefaultGatewayMetric" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "NameServer" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "Domain" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "RegistrationEnabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{A8C43F70-D71E-41C5-8CE7-41258A8A7E37}" /v "RegisterAdapterName" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "EnableDHCP" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "IPAddress" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "SubnetMask" /t REG_MULTI_SZ /d "0.0.0.0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "DefaultGateway" /t REG_MULTI_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "EnableDeadGWDetect" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{B54D8B1E-9214-40A6-90BA-39C6FC82E86B}" /v "DontAddDefaultGateway" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "UseDelayedAcceptance" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "HelperDllName" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\wshtcpip.dll" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "Mapping" /t REG_BINARY /d "0b00000003000000020000000100000006000000020000000100000000000000020000000000000006000000000000000000000006000000000000000100000006000000020000000200000011000000020000000200000000000000020000000000000011000000000000000000000011000000000000000200000011000000020000000300000000000000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\services\NDIS\Parameters" /v "MaxNumRssCpus" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d "1500" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d "1500" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*SpeedDuplex" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*FlowControl" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*RSS" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPConnectionOffloadIPv4" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPConnectionOffloadIPv6" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*LsoV1IPv4" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*LsoV2IPv4" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*LsoV2IPv6" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPUDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\00xx" /v "*TCPUDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF90-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF90-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF91-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF91-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF94-7B36-11D2-B20E-00C04F983E60}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2933BF94-7B36-11D2-B20E-00C04F983E60}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{333C7BC4-460F-11D0-BC04-0080C7055A83}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{333C7BC4-460F-11D0-BC04-0080C7055A83}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{373984C9-B845-449B-91E7-45AC83036ADE}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{373984C9-B845-449B-91E7-45AC83036ADE}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{6BF52A52-394A-11D3-B153-00C04F79FAA6}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{6BF52A52-394A-11D3-B153-00C04F79FAA6}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2049-217D-11DA-B2A4-000E7BBB2B09}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2049-217D-11DA-B2A4-000E7BBB2B09}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2051-217D-11DA-B2A4-000E7BBB2B09}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{884E2051-217D-11DA-B2A4-000E7BBB2B09}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A05-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A05-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A06-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A06-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A07-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A07-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A08-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A08-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A0A-F192-11D4-A65F-0040963251E5}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{88D96A0A-F192-11D4-A65F-0040963251E5}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{D2517915-48CE-4286-970F-921E881B8C5C}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{D2517915-48CE-4286-970F-921E881B8C5C}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{EE09B103-97E0-11CF-978F-00A02463E06F}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{EE09B103-97E0-11CF-978F-00A02463E06F}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F32-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F32-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F33-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F33-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F34-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F34-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F35-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F35-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F36-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F36-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F39-C551-11D3-89B9-0000F81FE221}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F5078F39-C551-11D3-89B9-0000F81FE221}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}" /v "Version" /t REG_SZ /d "*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}" /v "Flags" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF90-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF91-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{2933BF94-7B36-11D2-B20E-00C04F983E60}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{3050F819-98B5-11CF-BB82-00AA00BDCE0B}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{333C7BC4-460F-11D0-BC04-0080C7055A83}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{373984C9-B845-449B-91E7-45AC83036ADE}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{6BF52A52-394A-11D3-B153-00C04F79FAA6}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{884E2049-217D-11DA-B2A4-000E7BBB2B09}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{884E2051-217D-11DA-B2A4-000E7BBB2B09}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A05-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A06-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A07-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A08-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{88D96A0A-F192-11D4-A65F-0040963251E5}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{8E4062D9-FE1B-4B9E-AA16-5E8EEF68F48E}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{D2517915-48CE-4286-970F-921E881B8C5C}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{EE09B103-97E0-11CF-978F-00A02463E06F}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F32-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F33-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F34-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F35-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F36-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F5078F39-C551-11D3-89B9-0000F81FE221}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F6D90F12-9C73-11D3-B32E-00C04F990BB4}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{F6D90F14-9C73-11D3-B32E-00C04F990BB4}\iexplore" /v "Flags" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\Psched" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\services\NetBT" /v "Start" /t REG_DWORD /d "4" /f
exit