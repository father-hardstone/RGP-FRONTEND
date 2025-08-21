import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/service_card_new.dart';
import 'package:rgp_landing_take_3/components/sections/services_card_animations.dart';
import 'package:rgp_landing_take_3/components/sections/services_data.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rgp_landing_take_3/constants/responsive_breakpoints.dart';

class ServicesSection extends StatefulWidget {
  final ScrollController? scrollController;
  
  const ServicesSection({
    super.key,
    this.scrollController,
  });

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> with TickerProviderStateMixin {
  bool _isVisible = false;
  bool _controllersInitialized = false;
  bool _headingVisible = false;
  
  // Main animation controllers
  late AnimationController _backgroundController;
  late AnimationController _headingController;
  late AnimationController _gradientController; // For northern lights effect
  
  // Card animations (managed by helper class)
  late List<ServicesCardAnimations> _cardAnimations;
  
  // Main animations
  late Animation<double> _backgroundFadeAnimation;
  late Animation<Offset> _backgroundSlideAnimation;
  late Animation<double> _headingFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize main animation controllers
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _headingController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Initialize gradient controller for northern lights effect
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8), // 8-second sweep
      vsync: this,
    )..repeat(); // Continuous northern lights effect
    
    // Initialize card animations using helper class
    _cardAnimations = List.generate(
      3,
      (index) => ServicesCardAnimations(vsync: this, cardIndex: index),
    );
    
    // Initialize main animations
    _backgroundFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOut,
    ));
    
    _backgroundSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOut,
    ));
    
    _headingFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headingController,
      curve: Curves.easeOut,
    ));
    
    _controllersInitialized = true;
    
    // Add scroll listener if scrollController is provided
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScrollChanged);
    }
    
    // Start background animation immediately
    _backgroundController.forward();
    
    // Start with heading hidden
    _headingController.value = 0.0;
  }

  @override
  void dispose() {
    // Remove scroll listener
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_onScrollChanged);
    }
    
    _backgroundController.dispose();
    _headingController.dispose();
    _gradientController.dispose(); // Dispose gradient controller
    
    // Dispose card animations
    for (final animation in _cardAnimations) {
      animation.dispose();
    }
    
    super.dispose();
  }

  void _onScrollChanged() {
    if (!mounted || !_controllersInitialized) return;
    
    // Simple visibility detection based on scroll position
    final scrollOffset = widget.scrollController!.offset;
    
    // Consider section visible when scrolled past a certain point
    // Adjust this value based on your layout
    final isVisible = scrollOffset > 200; // Adjust this threshold
    
    // Debug output
    print('Services Section - Scroll: $scrollOffset, Visible: $isVisible, Current: $_headingVisible');
    
    if (isVisible != _headingVisible) {
      setState(() {
        _headingVisible = isVisible;
      });
      
      if (isVisible) {
        print('Services Section - Fading IN heading and background');
        _headingController.forward();
        _backgroundController.forward();
        
        // Start card animations when section becomes visible
        _startCardAnimations();
      } else {
        print('Services Section - Fading OUT heading and background');
        _headingController.reverse();
        _backgroundController.reverse();
        
        // Reset card animations when section becomes invisible
        _resetCardAnimations();
      }
    }
  }
  
  void _startCardAnimations() {
    if (!_controllersInitialized || _cardAnimations.isEmpty) return;
    
    // Start all card animations with staggered timing
    for (int i = 0; i < _cardAnimations.length; i++) {
      Future.delayed(Duration(milliseconds: 300 + (i * 150)), () {
        if (mounted && _controllersInitialized) {
          _cardAnimations[i].startAnimations();
        }
      });
    }
  }
  
  void _resetCardAnimations() {
    if (!_controllersInitialized || _cardAnimations.isEmpty) return;
    
    // Reset all card animations so they can be triggered again
    for (final animation in _cardAnimations) {
      animation.resetAnimations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final double width = sizingInformation.screenSize.width;
              final double height = sizingInformation.screenSize.height;
              final bool isMobile = ResponsiveBreakpoints.isMobile(width);
              final bool isTablet = ResponsiveBreakpoints.isTablet(width);
              final bool isDesktop = ResponsiveBreakpoints.isDesktop(width);
              final bool isLargeDesktop = ResponsiveBreakpoints.isLargeDesktop(width);

              // Calculate responsive dimensions
              final double sectionHeight = _calculateSectionHeight(width, height, isMobile);
              final double headingSize = TypographyConstants.getHeadingSize(width);

              return AnimatedBuilder(
                animation: _backgroundController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _backgroundSlideAnimation,
                    child: FadeTransition(
                      opacity: _backgroundFadeAnimation,
                      child: Container(
                        width: width,
                        height: sectionHeight,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/wallpaperflare.com_wallpaper (1).webp'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Stack(
                            children: [
                              // Northern lights overlay effect
                              Positioned.fill(
                                child: _controllersInitialized 
                                  ? AnimatedBuilder(
                                      animation: _gradientController,
                                      builder: (context, child) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xFF143877).withOpacity(0.11), // Subtle blue
                                                Color(0xFF143877).withOpacity(0.17), // Subtle blue
                                                Color(0xFF1A4A8F).withOpacity(0.18), // Medium blue
                                                Color(0xFF1A4A8F).withOpacity(0.18), // Medium blue 
                                                Color(0xFF143877).withOpacity(0.17), // Subtle blue
                                                Color(0xFF143877).withOpacity(0.11), // Subtle blue   
                                              ],
                                              stops: [0.1,0.2, 0.4, 0.6, 0.8, 0.9],
                                              transform: GradientRotation(
                                                _gradientController.value * 2 * 3.14159, // Full rotation
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF143877).withOpacity(0.2), // Fallback static overlay
                                      ),
                                    ),
                              ),
                              // Content on top of the spinning overlay
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Top spacing
                                  SizedBox(height: isMobile ? sectionHeight * 0.05 : sectionHeight * 0.06),
                                  
                                  // Section heading with fade-in effect
                                  FadeTransition(
                                    opacity: _headingFadeAnimation,
                                    child: Text(
                                      'Our Services',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: headingSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  
                                  // Middle spacing
                                  SizedBox(height: isMobile ? sectionHeight * 0.04 : sectionHeight * 0.05),
                                  
                                  // Services layout
                                  _buildServicesLayout(width, sectionHeight, isMobile),
                                  
                                  // Bottom spacing
                                  SizedBox(height: isMobile ? sectionHeight * 0.01 : sectionHeight * 0.015),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildServicesLayout(double width, double sectionHeight, bool isMobile) {
    // Guard against accessing animations before they're initialized
    if (!_controllersInitialized || _cardAnimations.isEmpty) {
      return Container(
        height: sectionHeight * 0.7,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (ResponsiveBreakpoints.isSmall(width)) {
      // Mobile and Tablet layout - vertical stacking
      return Container(
        height: sectionHeight * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ServicesData.services.asMap().entries.map((entry) {
              final int index = entry.key;
              final service = entry.value;
              
              return Flexible(
                child: SlideTransition(
                  position: _cardAnimations[index].cardSlideAnimation,
                  child: FadeTransition(
                    opacity: _cardAnimations[index].cardFadeAnimation,
                    child: ServiceCardNew(
                      title: service.title,
                      description: service.description,
                      imagePath: service.imagePath,
                      onDetailsPressed: () {
                        // Navigate to service page
                      },
                      isMobile: true,
                      imageFadeAnimation: _cardAnimations[index].imageFadeAnimation,
                      imageScaleAnimation: _cardAnimations[index].imageScaleAnimation,
                      titleFadeAnimation: _cardAnimations[index].titleFadeAnimation,
                      titleSlideAnimation: _cardAnimations[index].titleSlideAnimation,
                      textFadeAnimation: _cardAnimations[index].textFadeAnimation,
                      textSlideAnimation: _cardAnimations[index].textSlideAnimation,
                      buttonFadeAnimation: _cardAnimations[index].buttonFadeAnimation,
                      buttonSlideAnimation: _cardAnimations[index].buttonSlideAnimation,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      // Desktop and Large Desktop layout - horizontal row
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            children: ServicesData.services.asMap().entries.map((entry) {
              final int index = entry.key;
              final service = entry.value;
              
              return Expanded(
                child: SlideTransition(
                  position: _cardAnimations[index].cardSlideAnimation,
                  child: FadeTransition(
                    opacity: _cardAnimations[index].cardFadeAnimation,
                    child: ServiceCardNew(
                      title: service.title,
                      description: service.description,
                      imagePath: service.imagePath,
                      onDetailsPressed: () {
                        // Navigate to service page
                      },
                      isMobile: false,
                      imageFadeAnimation: _cardAnimations[index].imageFadeAnimation,
                      imageScaleAnimation: _cardAnimations[index].imageScaleAnimation,
                      titleFadeAnimation: _cardAnimations[index].titleFadeAnimation,
                      titleSlideAnimation: _cardAnimations[index].titleSlideAnimation,
                      textFadeAnimation: _cardAnimations[index].textFadeAnimation,
                      textSlideAnimation: _cardAnimations[index].textSlideAnimation,
                      buttonFadeAnimation: _cardAnimations[index].buttonFadeAnimation,
                      buttonSlideAnimation: _cardAnimations[index].buttonSlideAnimation,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  double _calculateSectionHeight(double width, double height, bool isMobile) {
    if (ResponsiveBreakpoints.isMobile(width)) {
      return height * 1.9;
    } else if (ResponsiveBreakpoints.isTablet(width)) {
      return height * 1.4; // Increased from 1.1 to 1.4 to accommodate taller cards
    } else if (ResponsiveBreakpoints.isDesktop(width)) {
      return height * 1.0;
    } else {
      return height * 0.9;
    }
  }
}
