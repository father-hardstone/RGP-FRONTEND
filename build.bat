@echo off
setlocal enabledelayedexpansion

echo 🚀 Starting RGP IT Global build process...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    echo Please install Flutter first: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

REM Clean previous build
echo 🧹 Cleaning previous build...
flutter clean

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Build for web with optimized settings
echo 🌐 Building Flutter web app...
flutter build web ^
    --release ^
    --web-renderer canvaskit ^
    --dart-define=FLUTTER_WEB_USE_SKIA=true ^
    --dart-define=FLUTTER_WEB_USE_SKIA_RENDERER=true ^
    --dart-define=FLUTTER_WEB_USE_SKIA_RENDERER_2D=true

REM Check if build was successful
if %errorlevel% equ 0 (
    echo ✅ Build completed successfully!
    echo 📁 Output directory: build/web
    echo 🚀 Ready for deployment!
    
    echo.
    echo 📊 Build size information:
    dir build\web /s | findstr "File(s)"
    
    echo.
    echo 📁 Main files:
    dir build\web /b | findstr /v "assets" | findstr /v "canvaskit" | findstr /v "icons"
    
) else (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo.
echo 🎉 Build process complete!
pause
