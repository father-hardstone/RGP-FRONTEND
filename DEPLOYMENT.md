# Deployment Guide for RGP Frontend

## Overview
This project is now configured for **static deployment** to Vercel. The Flutter app is built locally and the built files are deployed to Vercel.

## Prerequisites
- Flutter SDK installed locally
- Vercel CLI installed (`npm i -g vercel`)
- Vercel account and project created

## Deployment Steps

### 1. Build the Flutter Web App Locally
```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for web
flutter build web --release
```

### 2. Deploy to Vercel
```bash
# Deploy the built files
vercel --prod
```

## Alternative: Use GitHub Actions (Recommended)

### 1. Set up Vercel Secrets in GitHub
Go to your GitHub repository → Settings → Secrets and variables → Actions, and add:
- `VERCEL_TOKEN` - Your Vercel API token
- `ORG_ID` - Your Vercel organization ID  
- `PROJECT_ID` - Your Vercel project ID

### 2. Push to Main Branch
The GitHub Actions workflow will automatically:
- Build the Flutter app
- Deploy to Vercel
- Handle all the build complexity

## Why This Approach?

✅ **More reliable** - No Flutter installation issues on Vercel
✅ **Faster builds** - Local Flutter environment is optimized
✅ **Better debugging** - Build errors are caught locally
✅ **Consistent results** - Same build environment every time

## Troubleshooting

### Build Fails Locally
- Check Flutter version: `flutter --version`
- Clean and rebuild: `flutter clean && flutter pub get && flutter build web --release`

### Deployment Fails
- Ensure `build/web` directory exists
- Check Vercel project configuration
- Verify Vercel CLI is authenticated

## File Structure After Build
```
build/web/
├── index.html
├── main.dart.js
├── assets/
└── ...
```

This directory is what gets deployed to Vercel.
