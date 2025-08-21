#!/bin/bash

echo "🧹 Cleaning up unused assets..."

    # Remove unused BTI images
    echo "🗑️  Removing unused BTI images..."
    rm -f assets/bti1.jpg
    rm -f assets/bti2.jpg
    rm -f assets/bti3.jpg
    rm -f assets/bti4.jpg
    rm -f assets/bti5.jpg
    rm -f assets/bti6.jpg
    rm -f assets/bti8.png
    rm -f assets/bti9.jpg
    rm -f assets/bti10.jpg
    rm -f assets/bti11.jpg
    rm -f assets/bti12.jpg
    rm -f assets/bti13.jpg

# Remove unused background images
echo "🗑️  Removing unused background images..."
rm -f assets/background_test.jpg
rm -f assets/barback.png
rm -f assets/peakpx.jpg
rm -f "assets/peakpx (2).jpg"
rm -f assets/wallpaperflare.com_wallpaper.jpg

# Remove unused sliverbar
echo "🗑️  Removing unused sliverbar..."
rm -f assets/sliverbar/sbi1.jpg
rmdir assets/sliverbar 2>/dev/null || true

# Remove unused intropics
echo "🗑️  Removing unused intropics..."
rm -f assets/intropics/ipic1.jpg
rm -f assets/intropics/ipic2.jpg
rm -f assets/intropics/ipic3.jpg
rm -f assets/intropics/ipic4.jpg
rmdir assets/intropics 2>/dev/null || true

# Remove unused videos
echo "🗑️  Removing unused videos..."
rm -f assets/videos/about_us_vid.mp4
rm -f assets/videos/about_us_vid_2.webm
rm -f assets/videos/about_us_vid_3.webm
rm -f assets/videos/about_us_vid_4.mp4
rmdir assets/videos 2>/dev/null || true

# Remove unused testimonials
echo "🗑️  Removing unused testimonials..."
rm -f assets/testimonials/tpic1.jpg
rm -f assets/testimonials/tpic2.jpg
rm -f assets/testimonials/tpic3.jpg
rmdir assets/testimonials 2>/dev/null || true

# Remove unused logos
echo "🗑️  Removing unused logos..."
rm -f assets/logos/facebook_logo.png
rm -f assets/logos/linkedin_logo.png
rm -f assets/logos/twitter_logo.png
rm -f assets/logos/facebook_logo.ico
rmdir assets/logos 2>/dev/null || true

# Remove unused consultancy assets (keeping only the ones used)
echo "🗑️  Removing unused consultancy assets..."
rm -f assets/consultancy/cbi2.eps

# Remove unused infrastructure assets (keeping only the ones used)
echo "🗑️  Removing unused infrastructure assets..."
rm -f "assets/infrastructure_management/imbi2 (1).ai"
rm -f "assets/infrastructure_management/imbi2 (1).eps"
rm -f "assets/infrastructure_management/imbi2 (1).txt"
rm -f "assets/infrastructure_management/imbi2 (2).txt"

# Remove unused software solutions assets (keeping only the ones used)
echo "🗑️  Removing unused software solutions assets..."
rm -f assets/software_solutions/1014.eps
rm -f assets/software_solutions/License\ free.txt
rm -f assets/software_solutions/License\ premium.txt

echo "✅ Asset cleanup complete!"
echo ""
echo "📊 Remaining assets:"
echo "  - Background: bti5.webp"
echo "  - About us: bti7.jpg, aup1.webp"
echo "  - Services: wallpaperflare.com_wallpaper (1).webp"
echo "  - Service pages: Various WebP images in consultancy/, software_solutions/, infrastructure_management/"
echo ""
echo "💾 Estimated space saved: Significant reduction in build size"
echo "🚀 Build will now be faster and more efficient"
