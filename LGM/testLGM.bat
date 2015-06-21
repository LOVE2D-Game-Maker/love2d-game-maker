@REM Change the following line to "@set projupth=" and then the path to your Project Unique installation to by-pass having to type the path every time.
@set projupth=NA 

@if %projupth% == NA (
	@echo NOTE: You can bypass this step by changing line 1 of this batch file.
	@set /p projupth=Please enter the path to your Project Unique folder: 
)

@echo Deleting old LGM Project Unique folder...
@rd /s /q src\ProjectUnique
@del src\ProjectUnique.lua
@echo Copying new Project Unique source to LGM Project Unique folder...
@xcopy /s "%projupth%\Project Unique\Blank Template\ProjectUnique" src\ProjectUnique\
@copy "%projupth%\Project Unique\Blank Template\ProjectUnique.lua" src\ProjectUnique.lua
@echo Starting LGM...
@..\love2d\love src -console