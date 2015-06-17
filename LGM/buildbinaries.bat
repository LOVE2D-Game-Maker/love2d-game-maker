@echo This batch file builds LOVE Game Maker binaries from the source.
@echo If you don't know what this means or don't want to build binaries, please close this program now.
@echo.
@pause
@echo.
@if exist LGM.zip (
	@echo Deleting previously-made LGM.zip...
	@del LGM.zip
)
@if exist LGM.love (
	@echo Deleting previously-made LGM.love...
	@del LGM.love
)
@echo Zipping LGM source folder using 7-Zip...
@7zip\7za.exe > nul a LGM.zip .\src\*
@echo.
@echo Renaming LGM.zip file to LGM.love...
@ren LGM.zip LGM.love
@if exist LGM.love ( @echo LGM.love file successfully created from src folder! )
@echo.

@set win32pth=C:\love
@call :lovefolderisvalid 32-bit Windows

@if %result% == false (
	@echo The given path is not a valid LOVE Windows build!
) else (
	@echo Building 32-bit LGM Windows executable...
	@if exist bin\Windows\32bit ( @rd /s /q bin\Windows\32bit )
	@md bin\Windows\32bit
	@copy > nul /b %pth%\love.exe+LGM.love bin\Windows\32bit\LGM.exe
	@echo Copying all required dependencies/files from LOVE folder...
	@copy /b %pth%\DevIL.dll bin\Windows\32bit\DevIL.dll
	@copy /b bin\license.txt bin\Windows\32bit\license.txt
	@copy /b %pth%\love.dll bin\Windows\32bit\love.dll
	@copy /b %pth%\lua51.dll bin\Windows\32bit\lua51.dll
	@copy /b %pth%\mpg123.dll bin\Windows\32bit\mpg123.dll
	@copy /b %pth%\msvcp120.dll bin\Windows\32bit\msvcp120.dll
	@copy /b %pth%\msvcr120.dll bin\Windows\32bit\msvcr120.dll
	@copy /b %pth%\OpenAL32.dll bin\Windows\32bit\OpenAL32.dll
	@copy /b %pth%\SDL2.dll bin\Windows\32bit\SDL2.dll
	@echo Done!
	@echo Built binary can be found at "bin\Windows\32bit."
	@echo.
)

@call :lovefolderisvalid 64-bit Windows

@if %result% == false (
	@echo The given path is not a valid LOVE Windows build!
) else (
	@echo Building 64-bit LGM Windows executable...
	@if exist bin\Windows\64bit ( @rd /s /q bin\Windows\64bit )
	@md bin\Windows\64bit
	@copy > nul /b %pth%\love.exe+LGM.love bin\Windows\64bit\LGM.exe
	@echo Copying all required dependencies/files from LOVE folder...
	@copy /b %pth%\DevIL.dll bin\Windows\64bit\DevIL.dll
	@copy /b bin\license.txt bin\Windows\64bit\license.txt
	@copy /b %pth%\love.dll bin\Windows\64bit\love.dll
	@copy /b %pth%\lua51.dll bin\Windows\64bit\lua51.dll
	@copy /b %pth%\mpg123.dll bin\Windows\64bit\mpg123.dll
	@copy /b %pth%\msvcp120.dll bin\Windows\64bit\msvcp120.dll
	@copy /b %pth%\msvcr120.dll bin\Windows\64bit\msvcr120.dll
	@copy /b %pth%\OpenAL32.dll bin\Windows\64bit\OpenAL32.dll
	@copy /b %pth%\SDL2.dll bin\Windows\64bit\SDL2.dll
	@echo Done!
	@echo Built binary can be found at "bin\Windows\64bit."
	@echo.
)

@echo The batch file will now update the MacOSX version of LGM with the latest source found within the src folder.
@echo If you wish to not do so, please close the batch file.
@echo.
@pause
@echo.

@echo Copying new LGM.love into pre-built 64-bit LGM MacOSX executable...
@if exist bin\MacOSX\64bit\LGM.app\Contents\Resources\LGM.love ( @del bin\MacOSX\64bit\LGM.app\Contents\Resources\LGM.love )
@copy /b LGM.love bin\MacOSX\64bit\LGM.app\Contents\Resources\LGM.love
@echo Done!
@echo Built binary can be found at "bin\MacOSX\64bit."
@echo.
@echo Cleaning up...
@del LGM.love
@echo.

@if exist bin\MacOSX\64bit\LGM.app\Contents\Resources\LGM.love (
@if exist bin\Windows\32bit\LGM.exe (
@if exist bin\Windows\64bit\LGM.exe ( @echo All binaries built successfully! )))

@echo Thanks for contributing to the LOVE Game Maker project! :D
@echo.

@pause
@goto :eof

:lovefolderisvalid
@set /p pth=Please enter the path to your %1 build of LOVE: 
@set result=false

@if exist %pth%\love.exe ( @if exist %pth%\license.txt ( @if exist %pth%\DevIL.dll (
@if exist %pth%\love.dll ( @if exist %pth%\lua51.dll ( @if exist %pth%\mpg123.dll (
@if exist %pth%\msvcp120.dll ( @if exist %pth%\msvcr120.dll ( @if exist %pth%\OpenAL32.dll (
@if exist %pth%\SDL2.dll ( @set result=true))))))))))