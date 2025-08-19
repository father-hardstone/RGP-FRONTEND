import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class HeroSection extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const HeroSection({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;
  
  // New animation controllers for slide-in effects
  late AnimationController _headingSlideController;
  late AnimationController _subheadingSlideController;
  late AnimationController _buttonSlideController;
  
  // Slide-in animations
  late Animation<Offset> _headingSlideAnimation;
  late Animation<Offset> _subheadingSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  
  // Flag to track if animations are initialized
  bool _animationsInitialized = false;
  bool _slideAnimationsTriggered = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize gradient animation controller
    _gradientController = AnimationController(
      duration: const Duration(milliseconds: 4000), // 4 seconds for very slow, minimal effect
      vsync: this,
    );
    
    // Initialize slide-in animation controllers
    _headingSlideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _subheadingSlideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonSlideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Create gradient animation that loops continuously
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _gradientController,
      curve: Curves.easeInOut,
    ));
    
    // Create slide-in animations
    _headingSlideAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Start from much further right
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _headingSlideController,
      curve: Curves.easeOutCubic,
    ));
    
    _subheadingSlideAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Start from much further right
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _subheadingSlideController,
      curve: Curves.easeOutCubic,
    ));
    
    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Start from much further right
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _buttonSlideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Mark animations as initialized
    _animationsInitialized = true;
    
    // Start the continuous gradient animation
    _gradientController.repeat();
    
    // Add scroll listener to trigger slide-in animations
    widget.scrollController.addListener(_onScrollChanged);
    
    // Trigger initial slide-in animation on page load with delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && _animationsInitialized) {
        try {
          _triggerSlideInAnimations();
        } catch (e) {
          print('Initial animation error: $e');
        }
      }
    });
  }

  // Scroll listener to trigger slide-in animations when reaching the top
  void _onScrollChanged() {
    try {
      if (!mounted || !_animationsInitialized) return;
      
      final scrollOffset = widget.scrollController.offset;
      final screenHeight = MediaQuery.of(context).size.height;
      
      // Trigger slide-in animations as soon as hero section becomes visible
      if (scrollOffset <= screenHeight && !_slideAnimationsTriggered) {
        _slideAnimationsTriggered = true;
        _triggerSlideInAnimations();
      } else if (scrollOffset > screenHeight && _slideAnimationsTriggered) {
        // Trigger slide-out animations only when hero section is completely out of view
        _slideAnimationsTriggered = false;
        _triggerSlideOutAnimations();
      }
    } catch (e) {
      // Silently handle any scroll errors
      print('Scroll error: $e');
    }
  }
  
  // Trigger the staggered slide-in animations
  void _triggerSlideInAnimations() {
    try {
      if (!mounted || !_animationsInitialized) return;
      
      // Start with heading
      _headingSlideController.forward();
      
      // Then subheading after a delay
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted && _animationsInitialized) {
          _subheadingSlideController.forward();
        }
      });
      
      // Finally button after another delay
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted && _animationsInitialized) {
          _buttonSlideController.forward();
        }
      });
    } catch (e) {
      print('Slide-in error: $e');
    }
  }
  
  // Trigger the staggered slide-out animations
  void _triggerSlideOutAnimations() {
    try {
      if (!mounted || !_animationsInitialized) return;
      
      // Start with button (reverse order)
      _buttonSlideController.reverse();
      
      // Then subheading after a delay
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted && _animationsInitialized) {
          _subheadingSlideController.reverse();
        }
      });
      
      // Finally heading after another delay
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted && _animationsInitialized) {
          _headingSlideController.reverse();
        }
      });
    } catch (e) {
      print('Slide-out error: $e');
    }
  }
  
  // Reset slide-in animations to initial state (hidden to the right)
  void _resetSlideInAnimations() {
    try {
      if (!_animationsInitialized) return;
      
      _headingSlideController.value = 0.0; // Start from right
      _subheadingSlideController.value = 0.0; // Start from right
      _buttonSlideController.value = 0.0; // Start from right
    } catch (e) {
      print('Reset error: $e');
    }
  }

  @override
  void dispose() {
    if (_animationsInitialized) {
      _gradientController.dispose();
      _headingSlideController.dispose();
      _subheadingSlideController.dispose();
      _buttonSlideController.dispose();
    }
    widget.scrollController.removeListener(_onScrollChanged);
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
              final containerWidth = constraints.maxWidth;
              final containerHeight = MediaQuery.of(context).size.height;
              
              // Calculate responsive values
              double headingSize = _calculateHeadingSize(containerWidth, containerHeight);
              double textSize = _calculateTextSize(containerWidth, containerHeight);

              return Container(
                width: containerWidth,
                height: containerHeight, // Exactly equal to window height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded( // Use Expanded to prevent overflow
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SlideTransition(
                            position: _headingSlideAnimation,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Empowering\n',
                                    style: TextStyle(
                                      fontSize: headingSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Combined "Your IT Journey" with proper alignment
                                  WidgetSpan(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        // Minimal gradient effect for "Your"
                                        AnimatedBuilder(
                                          animation: _gradientAnimation,
                                          builder: (context, child) {
                                            return ClipRect(
                                              child: ShaderMask(
                                                shaderCallback: (bounds) {
                                                  // Use app bar colors: main blue and darker variants
                                                  return LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      const Color(0xFF1976D2), // App bar main blue
                                                      const Color(0xFF1565C0), // Darker variant
                                                      const Color(0xFF0D47A1), // Even darker variant
                                                      const Color(0xFF1976D2), // Back to main blue
                                                    ],
                                                    stops: [0.0, 0.33, 0.66, 1.0],
                                                    transform: GradientRotation(
                                                      _gradientAnimation.value * 2 * 3.14159, // Full rotation
                                                    ),
                                                  ).createShader(bounds);
                                                },
                                                blendMode: BlendMode.srcATop, // Better for text rendering
                                                child: Text(
                                                  'Your',
                                                  style: TextStyle(
                                                    fontSize: headingSize,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        // "IT Journey" always on the same line
                                        Text(
                                          ' IT Journey',
                                          style: TextStyle(
                                            fontSize: headingSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(height: 25),
                          SlideTransition(
                            position: _subheadingSlideAnimation,
                            child: Text(
                              'Unleash the Potential of\nCutting-Edge IT Solutions\nand Consultation Services',
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(height: 35),
                          SlideTransition(
                            position: _buttonSlideAnimation,
                            child: SizedBox(
                              height: 50,
                              width: 200,
                              child: PrimaryButton(
                                text: 'Learn More',
                                onPressed: () {
                                  // Use the scroll helper with safe scrolling
                                  widget.scrollHelper.scrollToSection(widget.scrollController, 3);
                                },
                                isMobile: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 0.05 * containerWidth,
                    ),
                  ],
                ),
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  double _calculateHeadingSize(double width, double height) {
    // Mobile-first responsive design
    if (width < 600) {
      // Small mobile screens - even smaller to prevent overflow
      return 28.0;
    } else if (width < 800) {
      // Medium mobile screens
      return 34.0;
    } else if (width < 1000) {
      // Large mobile/small tablet
      return 38.0;
    } else if (width >= 1400) {
      // Large desktop screens
      return width * 0.04;
    } else {
      // Medium desktop screens
      return 50.0;
    }
  }

  double _calculateTextSize(double width, double height) {
    // Mobile-first responsive design
    if (width < 600) {
      // Small mobile screens - even smaller to prevent overflow
      return 14.0;
    } else if (width < 800) {
      // Medium mobile screens
      return 16.0;
    } else if (width < 1000) {
      // Large mobile/small tablet
      return 18.0;
    } else if (width >= 1400) {
      // Large desktop screens
      return width * 0.018;
    } else {
      // Medium desktop screens
      return 20.0;
    }
  }
}
