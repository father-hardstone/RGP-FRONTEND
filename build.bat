@echo off
REM Flutter Web Build Script for Windows
echo 🚀 Starting Flutter Web Build...

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Build for web
echo 🔨 Building Flutter web app...
flutter build web --release

if %ERRORLEVEL% EQU 0 (
    echo ✅ Build completed successfully!
    echo 📁 Build output: build/web/
) else (
    echo ❌ Build failed!
    exit /b 1
)
