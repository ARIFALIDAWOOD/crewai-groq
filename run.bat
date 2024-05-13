@echo off
set "user_name=%USERNAME%"
for /f "skip=1" %%i in ('wmic csproduct get uuid') do if not defined device_id set "device_id=%%i"
set "device_id=%device_id:-=%"
set activate_bat=".Env-%user_name%-%device_id%\Scripts\activate.bat"
echo %activate_bat%
@REM pause
if not exist %activate_bat% (
    @echo on
    echo "Creating Virtual Environment"
    python -m venv .Env-%user_name%-%device_id%
    call %activate_bat%
    pip install -r config\req.txt
    @echo off
) else (
    call %activate_bat%
)
python app.py
cmd /k
