@echo off
chcp 65001 >nul
mode con: cols=54 lines=30
title windows-tweaks by roksov69
color 0F

set "LANG=en"

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   [!] Run as administrator required
    echo   [!] Запустите от имени администратора
    echo.
    pause
    exit /b
)

:main
cls
call :loadtext

echo.
echo   windows-tweaks by roksov69
echo   -------------------------
echo.
echo   %T_MENU1%
echo   %T_MENU2%
echo   %T_MENU3%
echo   %T_MENU4%
echo   %T_MENU5%
echo   %T_MENU0%
echo.
echo   -------------------------
echo   %T_MENU6%
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto customize
if "%choice%"=="2" goto activate
if "%choice%"=="3" goto specs
if "%choice%"=="4" goto cleanup
if "%choice%"=="5" goto apply_all_menu
if "%choice%"=="8" goto website
if "%choice%"=="9" set "RETURN=main" & goto switchlang
if "%choice%"=="0" exit /b
goto main

:website
start https://roksov69.github.io/
goto main

:apply_all_menu
cls
call :loadtext
echo.
echo   %T_APPLY_TITLE%
echo   -------------------------
echo.
echo   %T_APPLY1%
echo   %T_APPLY_DESC1%
echo   %T_APPLY_DESC2%
echo   %T_APPLY_DESC3%
echo   %T_APPLY_DESC4%
echo   %T_APPLY_DESC5%
echo   %T_APPLY_DESC6%
echo   %T_APPLY_DESC7%
echo.
echo   %T_APPLY2%
echo   %T_REVERT_DESC1%
echo   %T_REVERT_DESC2%
echo   %T_REVERT_DESC3%
echo   %T_REVERT_DESC4%
echo   %T_REVERT_DESC5%
echo   %T_REVERT_DESC6%
echo.
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto apply_all
if "%choice%"=="2" goto revert_all
if "%choice%"=="0" goto main
if "%choice%"=="9" set "RETURN=apply_all_menu" & goto switchlang
goto apply_all_menu

:apply_all
cls
call :loadtext
echo.
echo   %T_APPLYING%
echo.

:: 1. Рабочий стол (скрыть)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 1 /f >nul 2>&1

:: 2. Проводник (убрать главную, сеть, галерею + компактный режим + этот компьютер)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v HubMode /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1

:: 3. Кастомизация (цвета и классическое меню)
reg add "HKCU\Control Panel\Colors" /v Hilight /t REG_SZ /d "24 26 27" /f >nul 2>&1
reg add "HKCU\Control Panel\Colors" /v HotTrackingColor /t REG_SZ /d "24 26 27" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f >nul 2>&1

:: 4. Очистка (временные файлы)
del /q /f /s "%TEMP%\*" >nul 2>&1

echo   %T_DONE%
timeout /t 2 >nul
call :restart
goto apply_all_menu

:revert_all
cls
call :loadtext
echo.
echo   %T_REVERTING%
echo.

:: 1. Рабочий стол (вернуть)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul 2>&1

:: 2. Проводник (вернуть главную, сеть, галерею + обычный режим + домашняя страница)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /ve /d "CLSID_MSGraphHomeFolder" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v HubMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /ve /t REG_SZ /d "Gallery" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 2 /f >nul 2>&1

:: 3. Кастомизация (сброс цветов + светлая тема + меню windows 11)
reg add "HKCU\Control Panel\Colors" /v Hilight /t REG_SZ /d "0 120 215" /f >nul 2>&1
reg add "HKCU\Control Panel\Colors" /v HotTrackingColor /t REG_SZ /d "0 102 204" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1

echo   %T_DONE%
timeout /t 2 >nul
call :restart
goto apply_all_menu

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

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto desktop
if "%choice%"=="2" goto explorer
if "%choice%"=="3" goto cust_hilight
if "%choice%"=="4" goto cust_dark
if "%choice%"=="5" goto ctx_classic
if "%choice%"=="6" goto ctx_restore
if "%choice%"=="0" goto main
if "%choice%"=="9" set "RETURN=customize" & goto switchlang
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

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto hide
if "%choice%"=="2" goto show
if "%choice%"=="0" goto customize
if "%choice%"=="9" set "RETURN=desktop" & goto switchlang
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
echo   %T_EXP5%
echo   %T_BACK%
echo.
echo   -------------------------
if /i "%LANG%"=="ru" (
    echo   9  [ru]  en
) else (
    echo   9  ru  [en]
)
echo.

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto exp_remove_all
if "%choice%"=="2" goto exp_restore
if "%choice%"=="3" goto exp_compact
if "%choice%"=="4" goto exp_normal
if "%choice%"=="5" goto exp_thispc
if "%choice%"=="0" goto customize
if "%choice%"=="9" set "RETURN=explorer" & goto switchlang
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

call :restart
goto done_exp

:exp_compact
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f >nul 2>&1
call :restart
goto done_exp

:exp_normal
call :loadtext
echo.
echo   %T_PROCESS%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 0 /f >nul 2>&1
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

set "choice="
set /p "choice=  > "

if "%choice%"=="1" goto cln_temp
if "%choice%"=="0" goto main
if "%choice%"=="9" set "RETURN=cleanup" & goto switchlang
goto cleanup

:specs
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
set "choice="
set /p "choice=  > "
if "%choice%"=="0" goto main
if "%choice%"=="9" set "RETURN=specs" & goto switchlang
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

for /f "usebackq tokens=*" %%a in (`powershell -NoProfile -Command "$path = $env:TEMP; $size = (Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum; if ($size -eq $null) { $size = 0 }; $sizeMB = [math]::Round($size / 1MB, 2); Write-Output $sizeMB"`) do set "CLEANED_MB=%%a"

if "%CLEANED_MB%"=="" set "CLEANED_MB=0"

del /q /f /s "%TEMP%\*" >nul 2>&1

echo.
echo   %T_DONE%
echo   %T_CLN_SIZE% %CLEANED_MB% MB
echo   %T_CLN_PATH% %TEMP%
echo.
timeout /t 3 >nul
goto cleanup

:activate
cls
call :loadtext
echo.
echo   windows-tweaks by roksov69
echo   -------------------------
echo.
echo   %T_PROCESS%
timeout /t 1 >nul
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-Command','chcp 65001 >$null; [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; irm https://get.activated.win | iex'"
echo.
echo   %T_DONE%
echo.
timeout /t 3 >nul
goto main

:switchlang
if /i "%LANG%"=="ru" (set "LANG=en") else (set "LANG=ru")
if "%RETURN%"=="main" goto main
if "%RETURN%"=="customize" goto customize
if "%RETURN%"=="desktop" goto desktop
if "%RETURN%"=="explorer" goto explorer
if "%RETURN%"=="cleanup" goto cleanup
if "%RETURN%"=="specs" goto specs
if "%RETURN%"=="apply_all_menu" goto apply_all_menu
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
    set "T_MENU5=5  применить / отменить все"
    set "T_MENU6=8  сайт разработчика"
    set "T_MENU0=0  выход"
    set "T_APPLY_TITLE=применить / отменить все"
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
    set "T_EXP4=4  вернуть вид проводника"
    set "T_EXP5=5  открывать этот компьютер"
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
    set "T_APPLYING=применяю все настройки..."
    set "T_REVERTING=отменяю все настройки..."
    set "T_APPLY1=1  применить все"
    set "T_APPLY_DESC1=   - скрыть компьютер и корзину"
    set "T_APPLY_DESC2=   - убрать главную, сеть и галерею"
    set "T_APPLY_DESC3=   - включить компактный проводник"
    set "T_APPLY_DESC4=   - темное выделение цвета"
    set "T_APPLY_DESC5=   - темная тема"
    set "T_APPLY_DESC6=   - очистить временные файлы"
    set "T_APPLY_DESC7=   - включить классическое меню"
    set "T_APPLY2=2  отменить все"
    set "T_REVERT_DESC1=   - вернуть компьютер и корзину"
    set "T_REVERT_DESC2=   - вернуть главную, сеть и галерею"
    set "T_REVERT_DESC3=   - вернуть вид проводника"
    set "T_REVERT_DESC4=   - сбросить цвета"
    set "T_REVERT_DESC5=   - вернуть светлую тему"
    set "T_REVERT_DESC6=   - вернуть меню windows 11"
) else (
    set "T_MENU1=1  customization"
    set "T_MENU2=2  activate windows"
    set "T_MENU3=3  pc specs"
    set "T_MENU4=4  cleanup"
    set "T_MENU5=5  apply / revert all"
    set "T_MENU6=8  developer website"
    set "T_MENU0=0  exit"
    set "T_APPLY_TITLE=apply / revert all"
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
    set "T_EXP4=4  restore explorer view"
    set "T_EXP5=5  open this pc"
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
    set "T_APPLYING=applying all settings..."
    set "T_REVERTING=reverting all settings..."
    set "T_APPLY1=1  apply all"
    set "T_APPLY_DESC1=   - hide computer and recycle bin"
    set "T_APPLY_DESC2=   - remove home, network and gallery"
    set "T_APPLY_DESC3=   - enable compact explorer"
    set "T_APPLY_DESC4=   - dark highlight color"
    set "T_APPLY_DESC5=   - dark theme"
    set "T_APPLY_DESC6=   - clean temp files"
    set "T_APPLY_DESC7=   - enable classic context menu"
    set "T_APPLY2=2  revert all"
    set "T_REVERT_DESC1=   - restore computer and recycle bin"
    set "T_REVERT_DESC2=   - restore home, network and gallery"
    set "T_REVERT_DESC3=   - restore explorer view"
    set "T_REVERT_DESC4=   - reset colors"
    set "T_REVERT_DESC5=   - restore light theme"
    set "T_REVERT_DESC6=   - restore windows 11 context menu"
)
exit /b
