@echo off
setlocal
pushd %~dp0

set VSLANG=1033

:loop
IF NOT "%1"=="" (
    IF "%1"=="--webgpu-backend" (
        SET webgpu_backend=%2
        SHIFT
    )
    SHIFT
    GOTO :loop
)

:: Creates a string with, e.g., -G "Visual Studio 17 2022".
:: Needs to be run from a Visual Studio developer PowerShell or command prompt.
if defined VCINSTALLDIR (
    set VCINSTALLDIR_ESC=%VCINSTALLDIR:\=\\%
)
if defined VCINSTALLDIR (
    set "x=%VCINSTALLDIR_ESC:Microsoft Visual Studio\\=" & set "VsPathEnd=%"
)
if defined VCINSTALLDIR (
    set cmake_generator=-G "Visual Studio %VisualStudioVersion:~0,2% %VsPathEnd:~0,4%"
)
if not defined VCINSTALLDIR (
    set cmake_generator=
)

if not "%webgpu_backend%" == "" (
    set cmake_args_general=%cmake_args_general% -DWEBGPU_BACKEND=%webgpu_backend%
)

mkdir build 2> NUL
pushd build
cmake .. %cmake_generator% %cmake_args_general% || exit /b 1
cmake --build . --config Release || exit /b 1
popd
