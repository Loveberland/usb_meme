@echo off

:: keep path to this script for cleanup
set "SETUP_PATH=%~f0"
:: set path %TEMP% = C:\Users\<username>\AppData\Local\Temp
set "TEMP_EXE=%TEMP%\rick_main.exe"
:: set path to cleanup script
set "CLEANUP_BAT=%TEMP%\rick_cleanup.bat"

:: copy main.exe to %TEMP% as rick_main.exe
copy "%~dp0main.exe" "%TEMP_EXE%" > nul

:: create cleanup script to delete rick_main.exe, this setup.bat and itself after rick_main.exe exits
(
echo @echo off
echo :wait
:: sleep
echo ping 127.0.0.1 -n 3 ^> nul
:: check if rick_main.exe is still running
echo tasklist /fi "imagename eq rick_main.exe" 2^>nul ^| find /i "rick_main.exe" ^>nul
:: if rick_main.exe is still running, wait
echo if not errorlevel 1 goto wait
:: delete rick_main.exe, this setup.bat and itself
echo del "%TEMP_EXE%" 2^>nul
:: delete this setup.bat on USB if still plugged in
echo del "%SETUP_PATH%" 2^>nul
:: delete this cleanup script
echo del "%%~f0"
) > "%CLEANUP_BAT%"

:: Launch main executable
start /d "%TEMP%" "" "%TEMP_EXE%"

:: Launch cleanup script in minimized window to delete rick_main.exe, this setup.bat and itself after rick_main.exe exits
start /min /d "%TEMP%" "" cmd /c "%CLEANUP_BAT%"

:: Exit the setup script
exit
