@echo off
set WAR_NAME=VelonKan.war
set SOURCE_DIR=
set DEST_DIR=D:\Xampp\tomcat\webapps

echo Copying %WAR_NAME% to %DEST_DIR% ...
copy "%WAR_NAME%" "%DEST_DIR%\%WAR_NAME%" /Y

if %ERRORLEVEL%==0 (
    echo Deploy successful.
) else (
    echo Deploy failed.
)
pause
