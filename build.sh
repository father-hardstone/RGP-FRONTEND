#!/bin/bash

echo "🚀 Starting RGP IT Global build process..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    echo "Please install Flutter first: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Clean previous build
echo "🧹 Cleaning previous build..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Check if we're on a system with image optimization tools
if command -v convert &> /dev/null; then
    echo "🖼️  Optimizing images..."
    
    # Create optimized assets directory
    mkdir -p assets/optimized
    
    # Optimize critical images
    if [ -f "assets/bti5.webp" ]; then
        echo "  Background image (bti5.webp) is already optimized"
    fi
    
    if [ -f "assets/bti7.jpg" ]; then
        echo "  Optimizing bti7.jpg..."
        convert "assets/bti7.jpg" -quality 85 -strip "assets/optimized/bti7.jpg"
    fi
    
    if [ -f "assets/aup1.webp" ]; then
        echo "  Optimizing aup1.webp..."
        convert "assets/aup1.webp" -quality 85 -strip "assets/optimized/aup1.webp"
    fi
    
    if [ -f "assets/wallpaperflare.com_wallpaper (1).jpg" ]; then
        echo "  Optimizing wallpaperflare.jpg..."
        convert "assets/wallpaperflare.com_wallpaper (1).jpg" -quality 85 -strip "assets/optimized/wallpaperflare.jpg"
    fi
    
    echo "✅ Image optimization complete"
else
    echo "⚠️  ImageMagick not found, skipping image optimization"
    echo "  Install with: sudo apt-get install imagemagick (Ubuntu/Debian)"
    echo "  or: brew install imagemagick (macOS)"
fi

# Build for web with optimized settings
echo "🌐 Building Flutter web app..."
flutter build web \
    --release \
    --web-renderer canvaskit \
    --dart-define=FLUTTER_WEB_USE_SKIA=true \
    --dart-define=FLUTTER_WEB_USE_SKIA_RENDERER=true \
    --dart-define=FLUTTER_WEB_USE_SKIA_RENDERER_2D=true

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    echo "📁 Output directory: build/web"
    echo "🚀 Ready for deployment!"
    
    # Show build size information
    echo ""
    echo "📊 Build size information:"
    du -sh build/web/
    echo ""
    echo "📁 Main files:"
    ls -lh build/web/ | head -10
    
else
    echo "❌ Build failed!"
    exit 1
fi
