@echo off
setlocal enabledelayedexpansion
color 0F
title AnyDesk Resetter v2.0

:: ============================================================================
:: AnyDesk Resetter - Enhanced Version
:: Author: Sandalu Pabasara Perera
:: Description: Completely removes AnyDesk installation and related files
:: ============================================================================

:: Check if the script is running as Administrator
if "%1" neq "elevated" (
    call :PrintHeader
    echo [INFO] This script requires administrative privileges to function properly.
    echo [INFO] The script will restart with elevated privileges...
    echo.
    echo [PROMPT] Please accept the UAC prompt when it appears.
    echo.
    powershell -Command "Start-Process '%~0' -ArgumentList 'elevated' -Verb RunAs" 2>nul
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to restart with administrative privileges.
        echo [ERROR] Please run this script as Administrator manually.
        pause
        exit /b 1
    )
    exit /b 0
)

call :PrintHeader
echo [INFO] Running with administrative privileges...
echo.

:: Initialize variables
set "targetFolder=%AppData%\AnyDesk"
set "driverStorePath=C:\Windows\System32\DriverStore\FileRepository"
set "errorCount=0"
set "successCount=0"

:: Main execution flow
call :KillAnyDeskProcesses
call :CleanUserData
call :CleanDriverStore
call :CleanTempFiles
call :VerifyCleanup
call :PrintSummary

echo.
echo [INFO] Press any key to exit...
pause >nul
exit /b 0

:: ============================================================================
:: FUNCTIONS
:: ============================================================================

:PrintHeader
echo.
echo  +========================================================================+
echo  ^|                          AnyDesk Resetter v2.0                        ^|
echo  ^|                    Complete AnyDesk Removal Tool                       ^|
echo  +========================================================================+
echo.
goto :eof

:KillAnyDeskProcesses
echo [STEP 1/5] Terminating AnyDesk processes...
echo -------------------------------------------------------------------------
tasklist | find /i "AnyDesk.exe" >nul 2>&1
if !errorlevel! equ 0 (
    echo [INFO] AnyDesk process detected. Terminating...
    taskkill /im "AnyDesk.exe" /f >nul 2>&1
    if !errorlevel! equ 0 (
        echo [SUCCESS] AnyDesk process terminated successfully.
        set /a successCount+=1
    ) else (
        echo [ERROR] Failed to terminate AnyDesk process.
        set /a errorCount+=1
    )
) else (
    echo [INFO] No AnyDesk processes found running.
)
echo.
goto :eof

:CleanUserData
echo [STEP 2/5] Cleaning user data directory...
echo -------------------------------------------------------------------------
if exist "!targetFolder!" (
    echo [INFO] Removing AnyDesk user data: !targetFolder!
    
    :: Force close any handles to the directory
    handle.exe -a -p AnyDesk >nul 2>&1
    
    :: Try using robocopy to clear the directory first
    mkdir "%temp%\empty_folder" 2>nul
    robocopy "%temp%\empty_folder" "!targetFolder!" /purge >nul 2>&1
    rmdir "%temp%\empty_folder" >nul 2>&1
    
    :: Now try to remove the directory
    rd /s /q "!targetFolder!" 2>nul
    timeout /t 3 /nobreak >nul
    
    if exist "!targetFolder!" (
        echo [WARNING] First attempt failed. Trying alternative method...
        
        :: Use takeown and icacls for stubborn directories
        takeown /f "!targetFolder!" /r /d y >nul 2>&1
        icacls "!targetFolder!" /grant administrators:F /t /c /q >nul 2>&1
        
        :: Try PowerShell remove-item with force
        powershell -Command "Remove-Item -Path '!targetFolder!' -Recurse -Force -ErrorAction SilentlyContinue" 2>nul
        timeout /t 2 /nobreak >nul
        
        if exist "!targetFolder!" (
            echo [ERROR] Failed to remove user data directory completely.
            echo [INFO] You may need to restart Windows and run the script again.
            set /a errorCount+=1
        ) else (
            echo [SUCCESS] User data directory removed with alternative method.
            set /a successCount+=1
        )
    ) else (
        echo [SUCCESS] User data directory removed successfully.
        set /a successCount+=1
    )
) else (
    echo [INFO] User data directory not found.
)
echo.
goto :eof

:CleanDriverStore
echo [STEP 3/5] Cleaning driver store...
echo -------------------------------------------------------------------------
set "driverFound=false"
set "driverRemoved=true"

for /d %%F in ("!driverStorePath!\*AnyDesk*") do (
    set "driverFound=true"
    echo [INFO] Processing driver folder: %%~nxF
    
    takeown /f "%%F" /r /d y >nul 2>&1
    if !errorlevel! neq 0 (
        echo [WARNING] Failed to take ownership of %%F
    )
    
    icacls "%%F" /grant administrators:F /t /c /q >nul 2>&1
    if !errorlevel! neq 0 (
        echo [WARNING] Failed to set permissions for %%F
    )
    
    rd /s /q "%%F" 2>nul
    if exist "%%F" (
        echo [ERROR] Failed to remove driver folder: %%~nxF
        set "driverRemoved=false"
        set /a errorCount+=1
    ) else (
        echo [SUCCESS] Removed driver folder: %%~nxF
    )
)

for %%F in ("!driverStorePath!\*anydesk*") do (
    set "driverFound=true"
    echo [INFO] Processing driver file: %%~nxF
    
    takeown /f "%%F" /a >nul 2>&1
    icacls "%%F" /grant administrators:F /c /q >nul 2>&1
    del /f /q "%%F" 2>nul
    
    if exist "%%F" (
        echo [ERROR] Failed to remove driver file: %%~nxF
        set "driverRemoved=false"
        set /a errorCount+=1
    ) else (
        echo [SUCCESS] Removed driver file: %%~nxF
    )
)

if "!driverFound!" == "false" (
    echo [INFO] No AnyDesk drivers found in system.
) else (
    if "!driverRemoved!" == "true" (
        set /a successCount+=1
    )
)
echo.
goto :eof

:CleanTempFiles
echo [STEP 4/5] Cleaning temporary files...
echo -------------------------------------------------------------------------
echo [INFO] Cleaning temporary files directory...
DEL /F /S /Q "%USERPROFILE%\AppData\Local\Temp\*" >nul 2>nul
FOR /D %%P IN ("%USERPROFILE%\AppData\Local\Temp\*") DO RMDIR /S /Q "%%P" >nul 2>nul
echo [SUCCESS] Temporary files cleaned.
set /a successCount+=1
echo.
goto :eof

:VerifyCleanup
echo [STEP 5/5] Verifying cleanup...
echo -------------------------------------------------------------------------
set "cleanupSuccess=true"

if exist "!targetFolder!" (
    echo [ERROR] User data directory still exists.
    set "cleanupSuccess=false"
    set /a errorCount+=1
)

set "driverExists=false"
for /d %%F in ("!driverStorePath!\*AnyDesk*") do set "driverExists=true"
for %%F in ("!driverStorePath!\*anydesk*") do set "driverExists=true"

if "!driverExists!" == "true" (
    echo [ERROR] Some driver files still exist.
    set "cleanupSuccess=false"
    set /a errorCount+=1
)

if "!cleanupSuccess!" == "true" (
    echo [SUCCESS] All AnyDesk components have been successfully removed.
    set /a successCount+=1
) else (
    echo [WARNING] Some components could not be removed completely.
)
echo.
goto :eof

:PrintSummary
echo +========================================================================+
echo ^|                            OPERATION SUMMARY                           ^|
echo +========================================================================+
echo ^| Successful Operations: !successCount!                                               ^|
echo ^| Failed Operations:     !errorCount!                                               ^|
echo ^|                                                                        ^|
if !errorCount! equ 0 (
    echo ^| Status: ALL OPERATIONS COMPLETED SUCCESSFULLY                         ^|
    echo ^| AnyDesk has been completely removed from your system.                 ^|
) else (
    echo ^| Status: SOME OPERATIONS FAILED                                        ^|
    echo ^| Please review the errors above and try running the script again.      ^|
)
echo +========================================================================+
goto :eof
