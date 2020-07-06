@echo off
title getString by CabCon
COLOR 2F
echo Welcome To CabCons String Finder.  Created by CabCon Mods !
echo.
set /p Input= Enter String:
echo %id%
findstr /s /i "%Input%" *.* >FoundedStrings.txt
pause
