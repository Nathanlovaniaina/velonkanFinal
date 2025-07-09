@echo off
setlocal

rem === Chemins ===
set SRC=src\main\java\org\example
set WEBAPP=src\main\webapp
set RESOURCES=src\main\resources
set OUT=build
set LIB=lib

rem === Création du dossier de sortie ===
if not exist %OUT% mkdir %OUT%

rem === Construction de la liste des fichiers Java ===
echo Création de la liste des sources Java...
del sources.txt 2>nul
for /R %SRC% %%f in (*.java) do (
    echo %%f >> sources.txt
)

rem === Compilation ===
echo Compilation des fichiers Java...
javac -encoding UTF-8 -source 17 -target 17 -cp "%LIB%\*" -d %OUT%\WEB-INF\classes @sources.txt

if %ERRORLEVEL% neq 0 (
    echo Erreur de compilation.
    pause
    exit /b %ERRORLEVEL%
)

echo Compilation réussie.

rem === Copie des ressources web ===
echo Copie des fichiers web...
xcopy /E /I /Y %WEBAPP% %OUT%\

rem === Copie des fichiers de ressources ===
echo Copie des fichiers de ressources...
if exist %RESOURCES% (
    xcopy /E /I /Y %RESOURCES%\* %OUT%\WEB-INF\classes\
) else (
    echo Attention: le dossier de ressources %RESOURCES% n'existe pas!
)

rem === Copie des libs dans WEB-INF/lib ===
echo Copie des bibliothèques...
if not exist %OUT%\WEB-INF\lib mkdir %OUT%\WEB-INF\lib
xcopy /Y %LIB%\*.jar %OUT%\WEB-INF\lib\

rem === Création du fichier WAR ===
echo Création du WAR...
cd %OUT%
jar -cvf ../VelonKan.war *
cd ..

echo WAR généré avec succès : VelonKan.war
echo Vérifiez que application.properties est bien présent dans WEB-INF/classes
pause