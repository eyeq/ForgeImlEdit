@echo off
setlocal

set text=forge.iml
echo. >>%text%
findstr /v "</component> </module>" %text% >temp1.txt

for /f "delims=" %%a in (settings.gradle) do call :sub "%%a"
echo ^</component^> >>temp1.txt
echo ^</module^> >>temp1.txt

copy temp1.txt %text%
del temp1.txt

goto end



:sub
set str=%~1
set isread=false
set n=0
set module=
:loop
	call set c=%%str:~%n%,1%%
	if "%c%"=="" (
		goto endloop
	)
	set /a n+=1
	if "%c%"=="'" (
		if %isread%==true (
			set isread=false
			echo ^<orderEntry type="module" module-name="%module%" /^>^ >>temp1.txt
		) else (
			set isread=true
			set module=
		)
	) else (
		set module=%module%%c%
	)
	goto loop
:endloop
exit /b

:end
endlocal
