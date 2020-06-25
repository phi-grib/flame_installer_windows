@echo off
call flame_env\Scripts\activate.bat
pip install -e  .\flame\ 
flame -c config
