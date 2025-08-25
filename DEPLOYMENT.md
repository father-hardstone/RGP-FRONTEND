# RGP IT Global - Deployment Guide

## 🚀 Quick Deploy to Vercel

### Prerequisites
- Flutter SDK installed
- Vercel account
- Git repository

### Steps

1. **Clone and setup:**
   ```bash
   git clone <your-repo>
   cd RGP-FRONTEND
   flutter pub get
   ```

2. **Clean up unused assets (optional but recommended):**
```bash
   # On Windows
   cleanup_assets.bat
   
   # On macOS/Linux
   chmod +x cleanup_assets.sh
   ./cleanup_assets.sh
   ```

3. **Build locally (optional but recommended):**
   ```bash
   # On Windows
   build.bat
   
   # On macOS/Linux
   chmod +x build.sh
   ./build.sh
   ```

4. **Deploy to Vercel:**
```bash
vercel --prod
```

## 🔧 Performance Optimizations

### Asset Cleanup & Optimization
The project has been optimized by removing unused assets:

**Important Note:** Assets that are not listed in `pubspec.yaml` will NOT be bundled with your Flutter app, even if they exist in the assets folder. Flutter only includes assets that are explicitly declared.

**Removed Unused Assets:**
- ❌ 13 unused BTI images (bti1.jpg, bti2.jpg, etc.)
- ❌ 5 unused background images
- ❌ 4 unused intropics images
- ❌ 4 unused video files
- ❌ 3 unused testimonial images
- ❌ 4 unused logo files
- ❌ Various unused EPS and text files

**Remaining Essential Assets:**
- ✅ `bti5.webp` (main background - optimized WebP format)
- ✅ `bti7.jpg` (about us section)
- ✅ `aup1.webp` (about us section)
- ✅ `wallpaperflare.com_wallpaper (1).jpg` (services section)
- ✅ Service page images (consultancy, software, infrastructure)

**Benefits:**
- 🚀 **Faster builds** - Reduced asset processing time
- 💾 **Smaller bundle size** - Less data to transfer
- 📱 **Better mobile performance** - Faster loading on slow networks
- 🔧 **Easier maintenance** - Only essential assets to manage

### Image Optimization
The build scripts now include image optimization using ImageMagick:

```bash
# Install ImageMagick
# Ubuntu/Debian
sudo apt-get install imagemagick

# macOS
brew install imagemagick

# Windows
# Download from: https://imagemagick.org/script/download.php#windows
```

### Critical Assets Preloading
The HTML now preloads critical images:
- `bti5.webp` (background)
- `bti7.webp` (about us section)
- `aup1.webp` (about us section)
- `wallpaperflare.com_wallpaper (1).webp` (services section)
- Flutter engine files

### Background Image Loader
A smart loader that waits for the background image to load before showing the Flutter app:
- ✅ **Ensures background is ready** before app starts
- ✅ **Shows loading progress** with status updates
- ✅ **Prevents blank background** on slow connections
- ✅ **Fallback timeout** if loading takes too long
- ✅ **Smooth transition** when everything is ready

## 📱 Mobile Performance Issues & Solutions

### Problem: Background Image Not Loading on Mobile
**Causes:**
- Large image files (especially `bti5.jpg`)
- Slow mobile networks
- No image optimization
- Missing preloading

**Solutions Applied:**
1. ✅ **Image preloading** in HTML
2. ✅ **Build optimization** with CanvasKit renderer
3. ✅ **Better caching** headers in Vercel config
4. ✅ **Loading indicator** for better UX

### Problem: Slow Asset Loading
**Causes:**
- Flutter web generates many small files
- No compression
- Poor caching strategy

**Solutions Applied:**
1. ✅ **CanvasKit renderer** for better performance
2. ✅ **Aggressive caching** for static assets
3. ✅ **Compression** enabled in Vercel
4. ✅ **Preloading** of critical resources

## 🛠️ Vercel Configuration

### Build Command
```bash
flutter build web --release --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true
```

### Key Features
- **CanvasKit renderer** for better performance
- **Skia rendering** for consistent cross-platform rendering
- **Asset optimization** during build
- **Smart caching** for different file types

## 📊 Performance Monitoring

### Check Build Size
After building, check the output:
```bash
du -sh build/web/
```

### Monitor Loading Times
Use browser DevTools:
1. Open DevTools (F12)
2. Go to Network tab
3. Reload page
4. Check loading times for critical assets

### Mobile Testing
- Use Chrome DevTools device simulation
- Test on actual mobile devices
- Check network throttling

## 🚨 Troubleshooting

### Images Still Not Loading
1. **Check file paths** in `pubspec.yaml`
2. **Verify build output** contains all assets
3. **Check Vercel deployment** logs
4. **Clear browser cache**

### Slow Loading Persists
1. **Optimize images** manually if needed
2. **Check network tab** for bottlenecks
3. **Verify Vercel region** (closer = faster)
4. **Consider CDN** for static assets

### Build Failures
1. **Check Flutter version** compatibility
2. **Verify dependencies** are up to date
3. **Check build logs** for specific errors
4. **Try building locally** first

## 🔄 Continuous Deployment

### GitHub Actions (Recommended)
Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Vercel
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter build web --release --web-renderer canvaskit
      - uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

## 📈 Performance Metrics

### Target Metrics
- **First Contentful Paint**: < 2s
- **Largest Contentful Paint**: < 3s
- **Time to Interactive**: < 5s
- **Total Bundle Size**: < 5MB

### Monitoring Tools
- **Lighthouse** (Chrome DevTools)
- **PageSpeed Insights** (Google)
- **WebPageTest** (Real device testing)
- **Vercel Analytics** (Built-in)

## 🎯 Best Practices

1. **Always test on mobile** before deploying
2. **Optimize images** before adding to assets
3. **Use CanvasKit renderer** for production
4. **Monitor performance** regularly
5. **Cache aggressively** for static assets
6. **Preload critical resources**

## 📞 Support

If you encounter issues:
1. Check this guide first
2. Review Vercel deployment logs
3. Test locally with `flutter run -d chrome`
4. Check Flutter web documentation
5. Open an issue in the repository

---

**Last Updated:** December 2024  
**Flutter Version:** 3.16.0+  
**Vercel Version:** Latest
