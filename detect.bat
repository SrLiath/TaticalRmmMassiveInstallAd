@echo off
setlocal

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set ARCH=x64
) else (
    set ARCH=x86
)

for /f "tokens=4-5 delims=. " %%i in ('ver') do (
    set WINVER=%%i.%%j
)

echo Arquitetura: %ARCH%
echo Windows Version: %WINVER%
if "%WINVER%" == ""(

) else (
if "%ARCH%"=="x64" (
    @REM start "" "%~dp0app_x64.exe"
) else (
    @REM start "" "%~dp0app_x86.exe"
)
)


exit
