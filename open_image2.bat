@echo off
@echo off
title Initializing Secure Shell Access...
title ADVANCED HACKING SIMULATION...
chcp 65001 > NUL

:: --- Цветовая схема ---
@echo off
title Инициализация защищенного доступа...

:: Настройка цветов: Черный фон (0) и Ярко-голубой текст (B)
color 0B

echo.
echo [INIT] Initiating the Authentication Protocol...
timeout /t 1 /nobreak > NUL
echo [OK] Kernel integrity check...
timeout /t 1 /nobreak > NUL
echo [WARN] Low-level encryption detected. Starting enhanced security mode.
timeout /t 2 /nobreak > NUL

echo.
echo ===================================================================
echo ██████████████████████████████████████████████████████████████████
echo ===================================================================
echo.

:: Имитация полосы загрузки (регулируйте длину и скорость)
set "max_progress=100"
set "progress_bar_length=50"
set "progress=0"

:progress_loop
    :: Вычисление текущего состояния прогресса
    set /a "current_progress_step = (progress * progress_bar_length) / max_progress"
    
    :: Создание полосы загрузки
    set "bar="
    for /L %%i in (1,1,%current_progress_step%) do set "bar=!bar!█"
    
    :: Создание пробелов для заполнения оставшейся части полосы
    set "padding="
    set /a "remaining_space = progress_bar_length - current_progress_step"
    for /L %%i in (1,1,%remaining_space%) do set "padding=!padding! "
    
    :: Форматирование вывода
    echo [deleting data] Progress: %progress%%%
    
    :: Увеличение прогресса
    set /a "progress+=5"
    
    :: Задержка (уменьшите значение для ускорения)
    timeout /t 1 /nobreak > NUL
    
    :: Проверка окончания загрузки
    if %progress% LSS %max_progress% goto :progress_loop

echo.
echo [SUCCESS] Доступ к системе 'DEEP_CORE' успешно предоставлен.
echo.
echo *******************************************************************
echo *** YOU GOT ACCESS FOR A SPECIFIC TIME. ENJOY. ***
echo *******************************************************************
echo.

:: Вывод сообщения с задержкой
timeout /t 2 /nobreak > NUL
echo.
echo >>> ВСЁ. ИМИТАЦИЯ ЗАВЕРШЕНА.

echo.
echo ===================================================================

:: Вывод ASCII art с желтым цветом
color 0E
echo  ██████╗ ██████╗ ██╗   ██╗███████╗███████╗███████╗███████╗ ██████╗ ███████╗
echo  ██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝ ██╔════╝
echo  ██████╔╝██████╔╝██║   ██║███████╗███████╗███████╗███████╗██║  ███╗███████╗
echo  ██╔══██╗██╔══██╗██║   ██║╚════██║╚════██║╚════██║╚════██║██║   ██║╚════██║
echo  ██████╔╝██████╔╝╚██████╔╝███████║███████║███████║███████║╚██████╔╝███████║
echo  ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝
color 0B  :: Возвращаем основной цвет
echo ===================================================================
echo.

:: Вывод финальных сообщений с ярко-белым цветом
color 0F
echo >>> ВСЕ ДАННЫЕ ИМИТАЦИОННЫ. СИСТЕМА БЕЗОПАСНА.
echo >>> Нажмите любую клавишу для завершения симуляции.
color 0B  :: Возвращаем основной цвет        


pause
exit
