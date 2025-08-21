import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/contact_text_section.dart';
import 'package:rgp_landing_take_3/components/sections/contact_form_section.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/constants/responsive_breakpoints.dart';

class ContactSection extends StatefulWidget {
  final ScrollController? scrollController;

  const ContactSection({
    super.key,
    this.scrollController,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize gradient controller for northern lights effect
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8), // 8-second sweep
      vsync: this,
    )..repeat(); // Continuous northern lights effect
    
    _animationsInitialized = true;
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Stack(
                  children: [
                    // Background with northern lights effect (covers entire section)
                    Positioned.fill(
                      child: _animationsInitialized 
                        ? AnimatedBuilder(
                            animation: _gradientController,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF143877).withOpacity(0.35), // Blue at top
                                      Color(0xFF1A4A8F).withOpacity(0.45), // Lighter blue in middle
                                      Color(0xFF143877).withOpacity(0.35), // Blue
                                      Color(0xFF143877).withOpacity(0.2), // Fading out
                                      Color(0xFF143877).withOpacity(0.1), // More faded
                                      Colors.transparent, // Completely transparent at bottom
                                    ],
                                    stops: [0.0, 0.3, 0.6, 0.8, 0.9, 1.0],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF143877).withOpacity(0.4), // Blue at top
                                  Color(0xFF143877).withOpacity(0.3), // Fading
                                  Color(0xFF143877).withOpacity(0.2), // More faded
                                  Color(0xFF143877).withOpacity(0.1), // Very faded
                                  Colors.transparent, // Completely transparent at bottom
                                ],
                                stops: [0.0, 0.4, 0.7, 0.9, 1.0],
                              ),
                            ),
                          ),
                    ),
                    
                    // NEW: Additional spinning northern lights overlay for entire section
                    Positioned.fill(
                      child: _animationsInitialized 
                        ? AnimatedBuilder(
                            animation: _gradientController,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF143877).withOpacity(0.15), // Darker end
                                      Color(0xFF1A4A8F).withOpacity(0.25), // Lighter center
                                      Color(0xFF1A4A8F).withOpacity(0.35), // Lighter center
                                      Color(0xFF1A4A8F).withOpacity(0.25), // Lighter center
                                      Color(0xFF143877).withOpacity(0.15), // Darker end
                                    ],
                                    stops: [0.05, 0.15,0.5,0.85, 0.95],
                                    transform: GradientRotation(
                                      _gradientController.value * 2 * 3.14159, // Full rotation
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(), // Empty container when not initialized
                    ),
                    
                    // Content on top of the northern lights
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // For very small screens, wrap in SingleChildScrollView to prevent overflow
                        if (constraints.maxHeight < 600) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: sectionHeight - 100, // Reserve space for footer
                                  child: isMobile || isTablet
                                      ? _buildMobileLayout(width, sectionHeight, textSize, headingSize)
                                      : _buildDesktopLayout(width, sectionHeight, textSize, headingSize),
                                ),
                                
                                // Divider line
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 60), // Increased padding on sides
                                  height: 2, // Increased thickness from 1 to 2px
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                
                                // Copyright text
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Open GitHub profile in new tab
                                      // Note: In web, this would need to be implemented with url_launcher
                                    },
                                    child: Text(
                                      '© 2025 father_hardstone on GitHub. All rights reserved.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16, // Increased font size from 14 to 16
                                        fontWeight: FontWeight.bold, // Changed from w400 to bold
                                        // decoration: TextDecoration.underline, // Removed underline
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Normal layout for larger screens
                          return Column(
                            children: [
                              Expanded(
                                child: isMobile || isTablet
                                    ? _buildMobileLayout(width, sectionHeight, textSize, headingSize)
                                    : _buildDesktopLayout(width, sectionHeight, textSize, headingSize),
                              ),
                              
                              // Divider line
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 60), // Increased padding on sides
                                height: 2, // Increased thickness from 1 to 2px
                                color: Colors.white.withOpacity(0.3),
                              ),
                              
                              // Copyright text
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                child: GestureDetector(
                                  onTap: () {
                                    // Open GitHub profile in new tab
                                    // Note: In web, this would need to be implemented with url_launcher
                                  },
                                  child: Text(
                                    '© 2025 father_hardstone on GitHub. All rights reserved.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16, // Increased font size from 14 to 16
                                      fontWeight: FontWeight.bold, // Changed from w400 to bold
                                                                              // decoration: TextDecoration.underline, // Removed underline
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
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

  Widget _buildMobileLayout(double width, double height, double textSize, double headingSize) {
    return Column(
      children: [
        // Text section - 30% height
        Expanded(
          flex: 3,
          child: ContactTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: true,
          ),
        ),
        // Form section - 70% height
        Expanded(
          flex: 7, // 3:7 ratio gives 70% to form, 30% to text
          child: ContactFormSection(
            textSize: textSize,
            isMobile: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double width, double height, double textSize, double headingSize) {
    return Row(
      children: [
        // Text section (50% width)
        Expanded(
          flex: 1,
          child: ContactTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: false,
          ),
        ),
        // Form section (50% width)
        Expanded(
          flex: 1,
          child: ContactFormSection(
            textSize: textSize,
            isMobile: false,
          ),
        ),
      ],
    );
  }

  double _calculateSectionHeight(double width, double height, bool isMobile) {
    // Ensure minimum height is at least full screen height to prevent overflow
    // Use more conservative multipliers to avoid excessive height
    if (width < 600) {
      // Small mobile: ensure at least full height, but not too much more
      return height * 1.2 + 400.0; // Add 350px for mobile
    } else if (width < 800) {
      // Tablet: ensure at least full height
      return height * 1.1 + 500.0; // Add 350px for tablet
    } else if (width < 1200) {
      // Small desktop: ensure at least full height
      return height * 1.0 ; // No extra height for desktop
    } else {
      // Large desktop: ensure at least full height
      return height * 1.0 ; // No extra height for desktop
    }
    // if (height < 800) {
    //   return height * 1.0 + 300.0; // No extra height for desktop
    // } else {
    //   return height * 1.0 ; // No extra height for desktop
    // }
  }

  double _calculateTextSize(double width, bool isMobile) {
    if (width < 800) {
      return width * 0.035; // Mobile/Tablet: adjusted text size
    } else {
      return width * 0.015; // Desktop: larger text
    }
  }

  double _calculateHeadingSize(double width, bool isMobile) {
    if (width < 800) {
      return width * 0.06; // Mobile/Tablet: adjusted heading size
    } else {
      return width * 0.025; // Desktop: smaller heading
    }
  }
}
