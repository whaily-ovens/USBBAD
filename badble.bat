@echo off
:: Устанавливаем кодировку UTF-8, чтобы русский текст отображался корректно
chcp 65001 >nul
title Системный анализ...

:: 1. СБОР ДАННЫХ
set output="%USERPROFILE%\Desktop\data.txt"

echo === ОТЧЕТ О СИСТЕМЕ === > %output%
echo Дата и время: %date% %time% >> %output%
echo Пользователь: %username% >> %output%
echo. >> %output%

echo [ИНФОРМАЦИЯ О СИСТЕМЕ] >> %output%
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" >> %output%
echo. >> %output%

echo [СЕТЕВЫЕ НАСТРОЙКИ] >> %output%
ipconfig /all >> %output%
echo. >> %output%

echo [СПИСОК ПРОЦЕССОВ] >> %output%
tasklist >> %output%

echo Готово! Файл data.txt сохранен на рабочий стол.

:: 2. ЭФФЕКТ МАТРИЦЫ
cls
color 02
echo Запуск процесса обнуления...
timeout /t 20 >nul

:: Цикл для матрицы (примерно на 3-5 секунд)
for /l %%i in (1,1,150) do (
    echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
)

:: 3. ФИНАЛ
cls
color 0c
echo.
echo ===================================
echo        СИСТЕМА ОБНУЛЕНА.
echo ===================================
echo.
pause
