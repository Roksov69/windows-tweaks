@echo off
chcp 65001 >nul
mode con: cols=56 lines=32
title windows tweaks by roksov69
color 0F

set "LANG=ru"

:main
cls
call :loadtext

echo.
echo   windows tweaks by roksov69
echo   -------------------------
echo.
echo   %T_MENU1%
echo   %T_MENU2%
echo   %T_MENU3%
echo   %T_MENU4%
echo   %T_MENU0%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set /p "choice=  > "

if "%choice%"=="1" goto customize
if "%choice%"=="2" goto activate
if "%choice%"=="3" goto specs
if "%choice%"=="4" goto cleanup
if "%choice%"=="9" goto switchlang
if "%choice%"=="0" exit /b
goto main

:customize
cls
call :loadtext

echo.
echo   %T_CUST%
echo   -------------------------
echo.
echo   %T_CUST1%
echo   %T_CUST2%
echo   %T_CUST3%
echo   %T_CUST4%
echo   %T_CUST5%
echo   %T_CUST6%
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set /p "choice=  > "

if "%choice%"=="1" goto desktop
if "%choice%"=="2" goto explorer
if "%choice%"=="3" goto cust_hilight
if "%choice%"=="4" goto cust_dark
if "%choice%"=="5" goto ctx_classic
if "%choice%"=="6" goto ctx_restore
if "%choice%"=="0" goto main
if "%choice%"=="9" goto switchlang
goto customize

:desktop
cls
call :loadtext

echo.
echo   %T_DESK%
echo   -------------------------
echo.

set "PC=%T_VISIBLE%"
set "BIN=%T_VISIBLE_F%"

for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 2^>nul ^| find "REG_DWORD"') do if "%%a"=="0x1" set "PC=%T_HIDDEN%"
for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" 2^>nul ^| find "REG_DWORD"') do if "%%a"=="0x1" set "BIN=%T_HIDDEN_F%"

echo   %T_PC% : %PC%
echo   %T_BIN% : %BIN%
echo.
echo   %T_HIDE%
echo   %T_SHOW%
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set /p "choice=  > "

if "%choice%"=="1" goto hide
if "%choice%"=="2" goto show
if "%choice%"=="0" goto customize
if "%choice%"=="9" goto switchlang
goto desktop

:explorer
cls
call :loadtext

echo.
echo   %T_EXP%
echo   -------------------------
echo.
echo   %T_EXP1%
echo   %T_EXP2%
echo   %T_EXP3%
echo   %T_EXP4%
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set /p "choice=  > "

if "%choice%"=="1" goto exp_remove_all
if "%choice%"=="2" goto exp_restore
if "%choice%"=="3" goto exp_compact
if "%choice%"=="4" goto exp_thispc
if "%choice%"=="0" goto customize
if "%choice%"=="9" goto switchlang
goto explorer

:hide
call :loadtext
echo.
echo   %T_HIDING%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 1 /f >nul 2>&1
call :restart
goto done

:show
call :loadtext
echo.
echo   %T_SHOWING%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul 2>&1
call :restart
goto done

:exp_remove_all
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v HubMode /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f >nul 2>&1
call :restart
goto done_exp

:exp_restore
call :loadtext
echo.
echo   %T_PROCESS%

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /ve /d "CLSID_MSGraphHomeFolder" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v HubMode /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /ve /t REG_SZ /d "Gallery" /f >nul 2>&1

reg add "HKCU\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 0 /f >nul 2>&1

call :restart
goto done_exp

:exp_compact
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f >nul 2>&1
call :restart
goto done_exp

:exp_thispc
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
call :restart
goto done_exp

:cleanup
set "LANG=en"
cls
call :loadtext

echo.
echo   %T_CLN%
echo   -------------------------
echo.
echo   %T_CLN1%
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set /p "choice=  > "

if "%choice%"=="1" goto cln_temp
if "%choice%"=="0" goto main
if "%choice%"=="9" goto switchlang
goto cleanup

:specs
set "LANG=en"
cls
call :loadtext
echo.
echo   %T_SPECS%
echo   -------------------------
echo.

powershell -NoProfile -Command "chcp 65001 >$null; [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $cpu = (Get-CimInstance Win32_Processor).Name; $gpu = (Get-CimInstance Win32_VideoController).Name; $ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB); $disks = (Get-CimInstance Win32_DiskDrive | ForEach-Object { $size = [math]::Round($_.Size / 1GB); \"$($_.Caption) ($size GB)\" }) -join ', '; Write-Host '  %T_CPU%: ' -NoNewline; Write-Host $cpu; Write-Host '  %T_GPU%: ' -NoNewline; Write-Host $gpu; Write-Host '  %T_RAM%: ' -NoNewline; Write-Host \"$ram GB\"; Write-Host '  %T_DISK%: ' -NoNewline; Write-Host $disks"

echo.
echo   -------------------------
echo   %T_BACK%
echo.
set /p "choice=  > "
if "%choice%"=="0" goto main
goto specs

:cust_hilight
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Control Panel\Colors" /v Hilight /t REG_SZ /d "24 26 27" /f >nul 2>&1
reg add "HKCU\Control Panel\Colors" /v HotTrackingColor /t REG_SZ /d "24 26 27" /f >nul 2>&1
call :restart
goto done_cust

:cust_dark
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
call :restart
goto done_cust

:ctx_classic
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f >nul 2>&1
call :restart
goto done_cust

:ctx_restore
call :loadtext
echo.
echo   %T_PROCESS%
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
call :restart
goto done_cust

:cln_temp
call :loadtext
echo.
echo   %T_PROCESS%

for /f "usebackq tokens=*" %%a in (`powershell -NoProfile -Command "$path = $env:TEMP; $size = (Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum; $sizeMB = [math]::Round($size / 1MB, 2); Write-Output $sizeMB"`) do set "CLEANED_MB=%%a"

del /q /f /s "%TEMP%\*" >nul 2>&1

echo.
echo   %T_DONE%
echo   %T_CLN_SIZE% %CLEANED_MB% MB
echo   %T_CLN_PATH% %TEMP%
echo.
timeout /t 3 >nul
goto cleanup

:activate
set "LANG=en"
cls
call :loadtext
echo.
echo   windows tweaks by roksov69
echo   -------------------------
echo.
echo   %T_PROCESS%
timeout /t 1 >nul
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-Command','chcp 65001 >$null; [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; irm https://get.activated.win | iex'"
goto main

:switchlang
if /i "%LANG%"=="ru" (set "LANG=en") else (set "LANG=ru")
goto main

:restart
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 >nul
start explorer.exe
exit /b

:done
call :loadtext
echo.
echo   %T_DONE%
timeout /t 1 >nul
goto desktop

:done_exp
call :loadtext
echo.
echo   %T_DONE%
timeout /t 1 >nul
goto explorer

:done_cust
call :loadtext
echo.
echo   %T_DONE%
timeout /t 1 >nul
goto customize

:loadtext
if /i "%LANG%"=="ru" (
    set "T_MENU1=1  кастомизация"
    set "T_MENU2=2  активировать windows"
    set "T_MENU3=3  характеристики пк"
    set "T_MENU4=4  очистка"
    set "T_MENU0=0  выход"
    set "T_DESK=рабочий стол"
    set "T_PC=компьютер"
    set "T_BIN=корзина"
    set "T_VISIBLE=виден"
    set "T_VISIBLE_F=видна"
    set "T_HIDDEN=скрыт"
    set "T_HIDDEN_F=скрыта"
    set "T_HIDE=1  скрыть"
    set "T_SHOW=2  вернуть"
    set "T_BACK=0  назад"
    set "T_HIDING=скрываю..."
    set "T_SHOWING=возвращаю..."
    set "T_DONE=готово"
    set "T_PROCESS=обработка..."
    set "T_EXP=проводник"
    set "T_EXP1=1  убрать все (главная, сеть, галерея)"
    set "T_EXP2=2  вернуть все"
    set "T_EXP3=3  сделать компактнее проводник"
    set "T_EXP4=4  открывать этот компьютер"
    set "T_CUST=кастомизация"
    set "T_CUST1=1  рабочий стол"
    set "T_CUST2=2  проводник"
    set "T_CUST3=3  темное выделение цвета"
    set "T_CUST4=4  темная тема"
    set "T_CUST5=5  классическое меню"
    set "T_CUST6=6  меню windows 11"
    set "T_SPECS=характеристики пк"
    set "T_CPU=процессор"
    set "T_GPU=видеокарта"
    set "T_RAM=озу"
    set "T_DISK=жесткий диск"
    set "T_CLN=очистка"
    set "T_CLN1=1  очистить временные файлы"
    set "T_CLN_SIZE=освобождено:"
    set "T_CLN_PATH=папка:"
) else (
    set "T_MENU1=1  customization"
    set "T_MENU2=2  activate windows"
    set "T_MENU3=3  pc specs"
    set "T_MENU4=4  cleanup"
    set "T_MENU0=0  exit"
    set "T_DESK=desktop"
    set "T_PC=computer"
    set "T_BIN=recycle bin"
    set "T_VISIBLE=visible"
    set "T_VISIBLE_F=visible"
    set "T_HIDDEN=hidden"
    set "T_HIDDEN_F=hidden"
    set "T_HIDE=1  hide"
    set "T_SHOW=2  restore"
    set "T_BACK=0  back"
    set "T_HIDING=hiding..."
    set "T_SHOWING=restoring..."
    set "T_DONE=done"
    set "T_PROCESS=processing..."
    set "T_EXP=explorer"
    set "T_EXP1=1  remove all (home, network, gallery)"
    set "T_EXP2=2  restore all"
    set "T_EXP3=3  make explorer compact"
    set "T_EXP4=4  open this pc"
    set "T_CUST=customization"
    set "T_CUST1=1  desktop"
    set "T_CUST2=2  explorer"
    set "T_CUST3=3  dark highlight color"
    set "T_CUST4=4  dark theme"
    set "T_CUST5=5  classic menu"
    set "T_CUST6=6  windows 11 menu"
    set "T_SPECS=pc specs"
    set "T_CPU=cpu"
    set "T_GPU=gpu"
    set "T_RAM=ram"
    set "T_DISK=disk"
    set "T_CLN=cleanup"
    set "T_CLN1=1  clear temp files"
    set "T_CLN_SIZE=freed:"
    set "T_CLN_PATH=folder:"
)
exit /b
