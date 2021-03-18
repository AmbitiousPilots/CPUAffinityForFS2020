@echo off

:: EDIT CPU AFFINITY VALUE HERE
set cpuAffinity=14

:: DO NOT CHANGE BELOW THIS LINE
set gameExe=FlightSimulator.exe

title Launch Microsoft Flight Simulator with custom CPU Affinity Mask

:StartGame
start "" shell:AppsFolder\Microsoft.FlightSimulator_8wekyb3d8bbwe!App "-FastLaunch"
goto FindExe

:FindExe
tasklist|find "%gameExe%"
if "%ERRORLEVEL%" equ "0" (goto SetCpuAffinity)
timeout /t 1 /nobreak >nul
goto FindExe

:SetCpuAffinity
set gameExe=%gameExe:.exe=%
PowerShell -command "$Process = Get-Process %gameExe%; $Process.ProcessorAffinity=%cpuAffinity%"
goto :eof

exit