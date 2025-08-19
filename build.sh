#!/bin/bash

# Flutter Web Build Script for Vercel
set -e

echo "🚀 Starting Flutter Web Build for Vercel..."

# Install Flutter
echo "📥 Installing Flutter..."
curl -sSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.1-stable.tar.xz | tar -xJ
export PATH="$PATH:$PWD/flutter/bin"

# Verify Flutter installation
echo "🔍 Verifying Flutter installation..."
flutter doctor

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for web
echo "🔨 Building Flutter web app..."
flutter build web --release

echo "✅ Build completed successfully!"
echo "📁 Build output: build/web/"
