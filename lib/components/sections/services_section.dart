import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/service_card_new.dart';
import 'package:rgp_landing_take_3/components/sections/services_card_animations.dart';
import 'package:rgp_landing_take_3/components/sections/services_data.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rgp_landing_take_3/constants/responsive_breakpoints.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> with TickerProviderStateMixin {
  bool _isVisible = false;
  bool _controllersInitialized = false;
  
  // Main animation controllers
  late AnimationController _backgroundController;
  late AnimationController _headingController;
  
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
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    
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
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _headingController.dispose();
    
    // Dispose card animations
    for (final animation in _cardAnimations) {
      animation.dispose();
    }
    
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.01) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
        _startAnimations();
      }
    } else {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
        _stopAnimations();
      }
    }
  }

  void _startAnimations() {
    // Start background animation first
    _backgroundController.forward();
    
    // Start heading animation after background completes
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted && _isVisible) {
        _headingController.forward();
      }
    });
    
    // Start card animations with staggered timing
    for (int i = 0; i < _cardAnimations.length; i++) {
      Future.delayed(Duration(milliseconds: 270 + (i * 50)), () {
        if (mounted && _isVisible) {
          _cardAnimations[i].startAnimations();
        }
      });
    }
  }

  void _stopAnimations() {
    _backgroundController.reset();
    _headingController.reset();
    
    // Reset card animations
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

              return VisibilityDetector(
                key: const Key('services_section'),
                onVisibilityChanged: _onVisibilityChanged,
                child: AnimatedBuilder(
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
                              image: AssetImage('assets/bti11.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Column(
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildServicesLayout(double width, double sectionHeight, bool isMobile) {
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
                    textFadeAnimation: _cardAnimations[index].textFadeAnimation,
                    buttonFadeAnimation: _cardAnimations[index].buttonFadeAnimation,
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
                    textFadeAnimation: _cardAnimations[index].textFadeAnimation,
                    buttonFadeAnimation: _cardAnimations[index].buttonFadeAnimation,
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
      return height * 1.1;
    } else if (ResponsiveBreakpoints.isDesktop(width)) {
      return height * 1.0;
    } else {
      return height * 0.9;
    }
  }
}
