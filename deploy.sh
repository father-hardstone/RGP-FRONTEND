#!/bin/bash

# Flutter Web Deployment Script for Vercel
echo "🚀 Starting Flutter Web Build for Vercel..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for web
echo "🔨 Building Flutter web app..."
flutter build web --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful! App is ready for deployment."
    echo "📁 Build output: build/web/"
    echo "🌐 Deploy to Vercel using: vercel --prod"
else
    echo "❌ Build failed! Please check the errors above."
    exit 1
fi
