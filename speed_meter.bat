@echo off
title Speed Meter Simulation
color 0A

:main_menu
cls
echo ==================================================
echo               Speed Meter Simulation
echo ==================================================
echo Please enter the desired AU (Arbitrary Units) per second:
set /p au_per_sec="AU per second: "
echo Please enter the maximum time (in seconds) to achieve the desired speed:
set /p max_time="Max time (seconds): "

:: Validate input to ensure they are positive numbers
echo %au_per_sec% %max_time% | findstr /r "^[0-9][0-9]* [0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter positive numeric values.
    pause
    goto main_menu
)

:: Calculate FPS based on AU per second and max time
:: FPS = AU per second * max time
set /a fps=%au_per_sec% * %max_time%

:: Convert FPS to MPH
:: 1 FPS = 200,000 MPH
set /a mph=%fps% * 200000

:: Calculate delay time in milliseconds (1000 ms divided by FPS)
if %fps% neq 0 (
    set /a delay=1000 / %fps%
) else (
    set delay=1000
)

echo ==================================================
echo Simulating speed at %au_per_sec% AU/s (%fps% FPS, %mph% MPH)
echo (Press Ctrl+C to stop)
echo ==================================================

:: Start the simulation
:simulate
cls
echo Frame displayed at %au_per_sec% AU/s (%fps% FPS, %mph% MPH)
:: Introduce delay based on calculated milliseconds
ping localhost -n 1 -w %delay% >nul
goto simulate

:exit
cls
echo Thank you for using the Speed Meter Simulation. Goodbye!
pause
exit
