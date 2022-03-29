@echo off
call "%~dp0\..\bootstrap\python" -m UpdatePaths --directory ..\..\voidcrew\_maps %*
pause
