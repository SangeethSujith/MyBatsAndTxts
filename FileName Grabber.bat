@echo off
setlocal enabledelayedexpansion

set "folder_path=%cd%"
set "output_file=file_list.txt"
set "extensions=.mp4"  # Add desired extensions here

for %%f in (*%extensions%) do echo %%f >> "%output_file%"

echo Files listed in: "%output_file%"
pause
