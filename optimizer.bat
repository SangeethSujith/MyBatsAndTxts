@ECHO OFF
cls
set NLM=^


set NL=^^^%NLM%%NLM%^%NLM%%NLM%

SET divider=****************

echo %NL%OPTIMIZER

if not exist adb.exe (
	echo %NL%%divider%
	 echo Unable to find adb. Please make sure you've installed ADB and this script is in adb platform-tools folder%NL%before running this script
	echo %divider%
	pause
	EXIT /B 0
)

echo %NL%Checking connected devices. . .

adb.exe devices > devices.txt
if "%1"=="-v" (
	type devices.txt
)
findstr /c:"device" devices.txt | find /c /v "" > temp.txt
set /p devicecount=<temp.txt
del temp.txt
del devices.txt

IF "%devicecount%"=="1" (
	echo %divider%
    ECHO No devices found. Please make sure your device is connected, USB debugging is enabled, and that they are authorised%NL%^(check screen for prompt^), then run the script again
	echo %divider%
	pause
	EXIT /B 0
)
IF "%devicecount%" NEQ "2" (
	echo %divider%
    ECHO Multiple devices found, please disconnect all but the device you wish to use debloater script on, then run the script again
	echo %divider%
	pause
	EXIT /B 0
)

for /F "delims=" %%a in ('adb.exe shell getprop ro.product.device') do set DEVICE=%%a
for /F "delims=" %%a in ('adb.exe shell getprop ro.build.product') do set PRODUCT=%%a
for /F "delims=" %%a in ('adb.exe shell getprop ro.build.id') do set ID=%%a

echo %NL%Detected: %DEVICE% (%PRODUCT%)
echo Firmware: %ID%

echo %NL%Optimizing using speed-profile. The time taken for this process to get completed is dependent on the amount of apps and SoC present in your device. Recent phones can complete this job under 5 mins while older mid range might take 15-20 mins%NL%Note that disconnecting your device during this optimization will abort the process

echo.
pause
cls

echo %NL%This is an automated process just wait until it's completed by itself%NL%(on Android 10 will display "Success", on Nougat-Pie it just a new prompt line). . .
adb.exe shell cmd package bg-dexopt-job

echo %NL%Optimization is now finished!

echo %NL%Anytime you clean flash, complete restore apps from titanium backup/migrate or from Google (Play Store) and you face battery drain or lags, You may choose to open the script back and run this command

echo %NL%Press any key to exit. . .
pause>nul
exit