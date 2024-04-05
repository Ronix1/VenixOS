@echo off

:: enable autotunning
netsh int tcp set global autotuninglevel=normal >nul 2>&1