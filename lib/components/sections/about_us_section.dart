import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/about_us_text_section.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/constants/responsive_breakpoints.dart';

class AboutUsSection extends StatefulWidget {
  final ScrollController? scrollController;
  
  const AboutUsSection({
    super.key,
    this.scrollController,
  });

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection> with TickerProviderStateMixin {
  bool _isVisible = false;
  bool _animationsInitialized = false;
  late AnimationController _imageZoomController;
  late Animation<double> _imageZoomAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize image zoom animation controller
    _imageZoomController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Create zoom animation (zoom out when visible, zoom in when not)
    _imageZoomAnimation = Tween<double>(
      begin: 1.2, // Zoomed in (zoomed out when scrolled away)
      end: 1.0,   // Normal size (zoomed out when approached)
    ).animate(CurvedAnimation(
      parent: _imageZoomController,
      curve: Curves.easeInOutCubic,
    ));
    
    // Add scroll listener if scrollController is provided
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScrollChanged);
    }
    
    // Start with image zoomed in (zoomed out when scrolled away)
    _imageZoomController.value = 1.0;
    
    // Mark animations as initialized
    _animationsInitialized = true;
  }
  
  void _onScrollChanged() {
    if (!mounted || !_animationsInitialized) return;
    
    // Simple visibility detection based on scroll position
    final scrollOffset = widget.scrollController!.offset;
    
    // Consider section visible when scrolled to About Us section
    // Zoom out at 1534.7, zoom in at 3034.7
    final isVisible = scrollOffset > 1534.7 && scrollOffset < 3034.7;
    
    if (isVisible != _isVisible) {
      setState(() {
        _isVisible = isVisible;
      });
      
      if (isVisible) {
        // Zoom out when approached (animate to 1.0)
        _imageZoomController.forward();
      } else {
        // Zoom in when scrolled away (animate to 1.2)
        _imageZoomController.reverse();
      }
    }
  }

  @override
  void dispose() {
    // Remove scroll listener
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_onScrollChanged);
    }
    
    _imageZoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if animations aren't ready yet
    if (!_animationsInitialized) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          childCount: 1,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                final double height = MediaQuery.of(context).size.height;
                
                // Responsive breakpoints
              final bool isMobile = ResponsiveBreakpoints.isMobile(width);
              final bool isTablet = ResponsiveBreakpoints.isTablet(width);
              final bool isDesktop = ResponsiveBreakpoints.isDesktop(width);
                
                // Calculate responsive dimensions
                final double sectionHeight = _calculateSectionHeight(width, height, isMobile);
                final double textSize = _calculateTextSize(width, isMobile);
                final double headingSize = _calculateHeadingSize(width, isMobile);

                return Container(
                  width: width,
                  height: sectionHeight,
                child: ResponsiveBreakpoints.isSmall(width)
                      ? _buildMobileLayout(width, sectionHeight, textSize, headingSize)
                      : _buildDesktopLayout(width, sectionHeight, textSize, headingSize),
                );
              },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildMobileLayout(double width, double height, double textSize, double headingSize) {
    return Column(
      children: [
        // Text section with background
        Expanded(
          flex: 8,
          child: AboutUsTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: true,
          ),
        ),
        // Image section below text on mobile/tablet
        Expanded(
          flex: 2,
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _imageZoomAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _imageZoomAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/aup1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double width, double height, double textSize, double headingSize) {
    return Row(
      children: [
        // Text section with background (50% width)
        Expanded(
          flex: 1,
          child: AboutUsTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: false,
          ),
        ),
        // Image section (50% width)
        Expanded(
          flex: 1,
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _imageZoomAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _imageZoomAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/aup1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  double _calculateSectionHeight(double width, double height, bool isMobile) {
    if (isMobile) {
      return height * 1.1;
    } else if (width < 1200) {
      return height * 0.8;
    } else {
      return height * 0.85;
    }
  }

  double _calculateTextSize(double width, bool isMobile) {
    return TypographyConstants.getBodySize(width);
  }

  double _calculateHeadingSize(double width, bool isMobile) {
    return TypographyConstants.getHeadingSize(width);
  }
}
