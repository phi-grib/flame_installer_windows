@echo off
set CONDA="%userprofile%\miniconda3\Scripts\conda info --env"
::FOR /f "eol=#tokens=2delims= " %%a IN ('%conda% /i0 %1 ^|find "flame"') DO SET /a totdet=%%a
SETLOCAL ENABLEDELAYEDEXPANSION 
set flame=false
set update=false
For /f "tokens=*" %%a  IN  ('%CONDA%') DO (
	set z=%%a
	set LINE="!z:~0,5!"
	if not !LINE!=="flame" (
		rem goto :continue
	) else (
		echo "YES"
		set flame=true
		:loop
		set /p choice="Flame environment detected. Do you want to update it (YES/NO) :"
		if /i !choice!==yes (
			ECHO "Update selected"
			set update=true
			goto :update_env
		) else (
			if /i not !choice!==no (
				ECHO Please type yes or no
				goto :loop
			) else (
				echo Not updating the environment
				goto :EOF
			)
		)
	)	
)

:update_env
ECHO update: %update%
if %update%==true (
	ECHO updating environment....
	%userprofile%\miniconda3\Library\bin\conda.bat activate  
	%userprofile%\miniconda3\Library\bin\conda.bat activate flame & %userprofile%\miniconda3\Library\bin\conda.bat update --all 

	)
REM ECHO flame val: %flame%
if %flame%==false (
	ECHO installing environment....
	REM %userprofile%\miniconda3\Library\bin\conda.bat activate  base
	%userprofile%\miniconda3\Library\bin\conda.bat env create -f flame\environment.yml
	%userprofile%\miniconda3\Library\bin\conda.bat activate flame
	pip install  .\flame\ 
	REM echo y|flame -c config
	flame -c config -a silent
	)

GOTO :EOF
