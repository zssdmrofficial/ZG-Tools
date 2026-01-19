@echo off
SETLOCAL EnableDelayedExpansion

:: Set GitHub Organization and Hugging Face URL
set GITHUB_ORG=zssdmrofficial
set HF_PYTHON_REPO=https://huggingface.co/spaces/ZSSDMR/python

echo [1/3] Starting to clone repositories from GitHub...
echo -----------------------------------------------------------

:: List of repositories based on your screenshot
set repos=zssdmrofficial.github.io ussr.zssdmrofficial.github.io pinball.zssdmrofficial.github.io chat.zssdmrofficial.github.io chatgtp.zssdmrofficial.github.io law.zssdmrofficial.github.io ZG-Desktop ZG-Tools

for %%r in (%repos%) do (
    if exist "%%r" (
        echo [SKIP] Folder %%r already exists.
    ) else (
        echo [EXEC] Cloning %%r...
        git clone https://github.com/%GITHUB_ORG%/%%r.git
    )
)

echo.
echo [2/3] Starting to clone Python repository from Hugging Face...
echo -----------------------------------------------------------

if exist "python" (
    echo [SKIP] Folder "python" already exists.
) else (
    echo [EXEC] Cloning python project from Hugging Face...
    git clone %HF_PYTHON_REPO%
)

echo.
echo [3/3] Building ZG-Desktop project...
echo -----------------------------------------------------------

if exist "ZG-Desktop" (
    pushd ZG-Desktop
    echo [EXEC] Running npm install in ZG-Desktop...
    call npm install
    
    echo [EXEC] Running build in ZG-Desktop...
    call build
    popd
) else (
    echo [ERROR] ZG-Desktop directory not found, skipping build.
)

echo.
echo -----------------------------------------------------------
echo All tasks completed successfully!
pause