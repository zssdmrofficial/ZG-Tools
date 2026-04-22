@echo off
SETLOCAL EnableDelayedExpansion

set GITHUB_ORG=zssdmrofficial
set HF_PYTHON_REPO=https://huggingface.co/spaces/ZSSDMR/python
set HF_SPACE_REPO=https://huggingface.co/spaces/ZSSDMR/space

echo [1/4] Starting to clone repositories from GitHub...
echo -----------------------------------------------------------

set repos=zssdmrofficial.github.io ussr.zssdmrofficial.github.io pinball.zssdmrofficial.github.io chat.zssdmrofficial.github.io chatgtp.zssdmrofficial.github.io law.zssdmrofficial.github.io space.zssdmrofficial.github.io ZG-Desktop ZG-Tools searxng

for %%r in (%repos%) do (
    if exist "%%r" (
        echo [SKIP] Folder %%r already exists.
    ) else (
        echo [EXEC] Cloning %%r...
        git clone https://github.com/%GITHUB_ORG%/%%r.git
    )
)

echo.
echo [2/4] Starting to clone Python repositories from Hugging Face...
echo -----------------------------------------------------------

if exist "python" (
    echo [SKIP] Folder "python" already exists.
) else (
    echo [EXEC] Cloning python project from Hugging Face...
    git clone %HF_PYTHON_REPO%
)

echo.
echo [3/4] Starting to clone space repositories from Hugging Face...
echo -----------------------------------------------------------

if exist "space" (
    echo [SKIP] Folder "space" already exists.
) else (
    echo [EXEC] Cloning space project from Hugging Face...
    git clone %HF_SPACE_REPO%
)

echo.
echo [4/4] Building ZG-Desktop project...
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