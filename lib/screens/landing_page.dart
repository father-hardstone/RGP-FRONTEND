import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/app_bars/top_app_bar.dart';
import 'package:rgp_landing_take_3/components/app_bars/main_app_bar.dart';
import 'package:rgp_landing_take_3/components/sections/hero_section.dart';
import 'package:rgp_landing_take_3/components/sections/services_section.dart';
import 'package:rgp_landing_take_3/components/sections/why_choose_us_section.dart';
import 'package:rgp_landing_take_3/components/sections/about_us_section.dart';
import 'package:rgp_landing_take_3/components/sections/contact_section.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ScrollControllerHelper _scrollHelper = ScrollControllerHelper();
  
  // Background animation controllers for both effects
  late AnimationController _initialZoomController; // For initial page load zoom-out
  late AnimationController _scrollZoomController;  // For scroll-dependent zoom
  late Animation<double> _initialZoomAnimation;
  late Animation<double> _scrollZoomAnimation;
  
  // Track scroll position for zoom effect
  double _currentScrollOffset = 0.0;
  static const double _maxScrollOffset = 500.0; // Max scroll distance for zoom effect
  static const double _minScale = 1.0; // Normal size when at top
  static const double _maxScale = 1.15; // Max zoom when scrolled down
  static const double _initialScale = 1.3; // Starting scale on page load
  
  // Flag to track if animations are initialized
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollHelper.initializeScrollController(_scrollController);
    
    // Pass the landing page instance to the scroll helper
    _scrollHelper.setLandingPage(this);
    
    // Calculate page lengths after the first frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _scrollHelper.calculatePageLengths(context);
      }
    });
    
    // Initialize initial zoom controller (page load effect)
    _initialZoomController = AnimationController(
      duration: const Duration(milliseconds: 2500), // 2.5 seconds for initial zoom-out
      vsync: this,
    );
    
    // Initialize scroll zoom controller
    _scrollZoomController = AnimationController(
      duration: const Duration(milliseconds: 100), // Quick, responsive animation
      vsync: this,
    );
    
    // Create initial zoom animation (zoom-out effect on page load)
    _initialZoomAnimation = Tween<double>(
      begin: _initialScale,
      end: _minScale,
    ).animate(CurvedAnimation(
      parent: _initialZoomController,
      curve: Curves.easeOutCubic,
    ));
    
    // Create scroll zoom animation (background zoom based on scroll position)
    _scrollZoomAnimation = Tween<double>(
      begin: _minScale,
      end: _maxScale,
    ).animate(CurvedAnimation(
      parent: _scrollZoomController,
      curve: Curves.easeOutCubic,
    ));
    
    // Start initial zoom animation
    _initialZoomController.forward();
    
    // Add scroll listener for background zoom effect
    _scrollController.addListener(_onScrollChanged);
    
    _animationsInitialized = true;
  }
  
  // Handle scroll changes for background zoom effect
  void _onScrollChanged() {
    if (!_animationsInitialized) return;
    
    final double scrollOffset = _scrollController.offset;
    _currentScrollOffset = scrollOffset;
    
    // Calculate scroll-based zoom progress
    final double scrollProgress = (scrollOffset / _maxScrollOffset).clamp(0.0, 1.0);
    
    // Update scroll zoom controller
    _scrollZoomController.value = scrollProgress;
  }
  
  // Safe scroll method that bypasses custom scroll behavior
  void safeScrollTo(double targetOffset) {
    if (!_animationsInitialized) return;
    
    // Use standard scroll controller methods
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    _scrollController.dispose();
    if (_animationsInitialized) {
      _initialZoomController.dispose();
      _scrollZoomController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if animations aren't ready yet
    if (!_animationsInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: Stack(
        children: [
          // Background image with combined zoom effects
          AnimatedBuilder(
            animation: Listenable.merge([_initialZoomAnimation, _scrollZoomAnimation]),
            builder: (context, child) {
              // Combine both zoom effects: initial zoom + scroll zoom
              final double combinedScale = _initialZoomAnimation.value + _scrollZoomAnimation.value;
              
              return Transform.scale(
                scale: combinedScale,
                child: Image.asset(
                  'assets/bti5.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isLargeScreen = constraints.maxWidth >= 1200;
              
              return Scrollbar(
                controller: _scrollController,
                thumbVisibility: isLargeScreen, // Only show on large screens
                thickness: 8.0, // Thinner, more elegant scrollbar
                radius: const Radius.circular(4.0), // Rounded corners
                child: CustomScrollView(
                  controller: _scrollController,
                  // Use ClampingScrollPhysics to prevent overscroll
                  physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    // Top app bar (thin black bar)
                    TopAppBar(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                    
                    // Main app bar (blue bar with title and contact button)
                    MainAppBar(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                    
                    // Hero section
                    HeroSection(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                    
                    // Services section
                    const ServicesSection(),
                    
                    // Why choose us section
                    const WhyChooseUsSection(),
                    
                    // About us section
                    const AboutUsSection(),
                    
                    // Contact section
                    ContactSection(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
