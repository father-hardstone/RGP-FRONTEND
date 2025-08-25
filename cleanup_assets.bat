@echo off
setlocal enabledelayedexpansion

echo 🧹 Cleaning up unused assets...

REM Remove unused BTI images
echo 🗑️  Removing unused BTI images...
del /f /q "assets\bti1.jpg" 2>nul
del /f /q "assets\bti2.jpg" 2>nul
del /f /q "assets\bti3.jpg" 2>nul
del /f /q "assets\bti4.jpg" 2>nul
del /f /q "assets\bti5.jpg" 2>nul
del /f /q "assets\bti6.jpg" 2>nul
del /f /q "assets\bti8.png" 2>nul
del /f /q "assets\bti9.jpg" 2>nul
del /f /q "assets\bti10.jpg" 2>nul
del /f /q "assets\bti11.jpg" 2>nul
del /f /q "assets\bti12.jpg" 2>nul
del /f /q "assets\bti13.jpg" 2>nul

REM Remove unused background images
echo 🗑️  Removing unused background images...
del /f /q "assets\background_test.jpg" 2>nul
del /f /q "assets\barback.png" 2>nul
del /f /q "assets\peakpx.jpg" 2>nul
del /f /q "assets\peakpx (2).jpg" 2>nul
del /f /q "assets\wallpaperflare.com_wallpaper.jpg" 2>nul

REM Remove unused sliverbar
echo 🗑️  Removing unused sliverbar...
del /f /q "assets\sliverbar\sbi1.jpg" 2>nul
rmdir "assets\sliverbar" 2>nul

REM Remove unused intropics
echo 🗑️  Removing unused intropics...
del /f /q "assets\intropics\ipic1.jpg" 2>nul
del /f /q "assets\intropics\ipic2.jpg" 2>nul
del /f /q "assets\intropics\ipic3.jpg" 2>nul
del /f /q "assets\intropics\ipic4.jpg" 2>nul
rmdir "assets\intropics" 2>nul

REM Remove unused videos
echo 🗑️  Removing unused videos...
del /f /q "assets\videos\about_us_vid.mp4" 2>nul
del /f /q "assets\videos\about_us_vid_2.webm" 2>nul
del /f /q "assets\videos\about_us_vid_3.webm" 2>nul
del /f /q "assets\videos\about_us_vid_4.mp4" 2>nul
rmdir "assets\videos" 2>nul

REM Remove unused testimonials
echo 🗑️  Removing unused testimonials...
del /f /q "assets\testimonials\tpic1.jpg" 2>nul
del /f /q "assets\testimonials\tpic2.jpg" 2>nul
del /f /q "assets\testimonials\tpic3.jpg" 2>nul
rmdir "assets\testimonials" 2>nul

REM Remove unused logos
echo 🗑️  Removing unused logos...
del /f /q "assets\logos\facebook_logo.png" 2>nul
del /f /q "assets\logos\linkedin_logo.png" 2>nul
del /f /q "assets\logos\twitter_logo.png" 2>nul
del /f /q "assets\logos\facebook_logo.ico" 2>nul
rmdir "assets\logos" 2>nul

REM Remove unused consultancy assets
echo 🗑️  Removing unused consultancy assets...
del /f /q "assets\consultancy\cbi2.eps" 2>nul

REM Remove unused infrastructure assets
echo 🗑️  Removing unused infrastructure assets...
del /f /q "assets\infrastructure_management\imbi2 (1).ai" 2>nul
del /f /q "assets\infrastructure_management\imbi2 (1).eps" 2>nul
del /f /q "assets\infrastructure_management\imbi2 (1).txt" 2>nul
del /f /q "assets\infrastructure_management\imbi2 (2).txt" 2>nul

REM Remove unused software solutions assets
echo 🗑️  Removing unused software solutions assets...
del /f /q "assets\software_solutions\1014.eps" 2>nul
del /f /q "assets\software_solutions\License free.txt" 2>nul
del /f /q "assets\software_solutions\License premium.txt" 2>nul

echo ✅ Asset cleanup complete!
echo.
echo 📊 Remaining assets:
echo   - Background: bti5.webp
echo   - About us: bti7.jpg, aup1.webp
echo   - Services: wallpaperflare.com_wallpaper (1).webp
echo   - Service pages: Various WebP images in consultancy/, software_solutions/, infrastructure_management/
echo.
echo 💾 Estimated space saved: Significant reduction in build size
echo 🚀 Build will now be faster and more efficient

pause
