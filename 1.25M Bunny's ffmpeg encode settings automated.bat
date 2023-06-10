pushd "%2"

SET paths=paths.txt

SET /A ffmpeg_qv=24

if EXIST %paths% (
    for /f "tokens=*" %%a in (%paths%) do (
        echo Changing to directory %%a
        pushd "%%a"
        CALL :ffmpeg
    )
) else (
    CALL :ffmpeg
)
pause
EXIT /B %ERRORLEVEL%

:ffmpeg
    for /R %%A in (*.mp4, *.avi, *.mov, *.wmv, *.ts, *.m2ts, *.mkv, *.mts) do (
        echo Processing "%%A"
ffmpeg -i "%%A" -map 0:0 -map 0:1  -c:v hevc_nvenc -cq 0 -qmin 0 -qmax 30 -c:a libopus -ac 2 -b:a 128K -b_ref_mode 0 -maxrate 1.25M -bufsize 20M -c:a copy "%%A_HEVC.mp4"
echo Processed %%A
    )
GOTO :EOF