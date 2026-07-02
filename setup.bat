@echo off

:: keep path to this script for cleanup
set "SETUP_PATH=%~f0"
:: set path %TEMP% = C:\Users\<username>\AppData\Local\Temp
set "TEMP_SCRIPT=%TEMP%\rick_main.py"
:: set path to cleanup script
set "CLEANUP_BAT=%TEMP%\rick_cleanup.bat"

:: copy main.py to %TEMP% as rick_main.py
copy "%~dp0main.py" "%TEMP_SCRIPT%" > nul

:: create cleanup script to delete rick_main.py, this setup.bat and itself after rick_main.py exits
(
echo @echo off
echo :wait
:: sleep
echo ping 127.0.0.1 -n 3 ^> nul
:: check if python is running this specific script
echo wmic process where "name='python.exe' and commandline like '%%rick_main.py%%'" get processid 2^>nul ^| findstr [0-9] ^>nul
:: if rick_main.py is still running, wait
echo if not errorlevel 1 goto wait
:: delete rick_main.py, this setup.bat and itself
echo del "%TEMP_SCRIPT%" 2^>nul
:: delete this setup.bat on USB if still plugged in
echo del "%SETUP_PATH%" 2^>nul
:: delete this cleanup script
echo del "%%~f0"
) > "%CLEANUP_BAT%"

:: Launch main python script
start /d "%TEMP%" "" python "%TEMP_SCRIPT%"

:: Launch cleanup script in minimized window to delete rick_main.py, this setup.bat and itself after rick_main.py exits
start /min /d "%TEMP%" "" cmd /c "%CLEANUP_BAT%"

:: Exit the setup script
exit
