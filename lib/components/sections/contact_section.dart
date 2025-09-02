import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late AnimationController _breathingController1;
  late AnimationController _breathingController2;
  late AnimationController _breathingController3;
  late Animation<double> _breathingAnimation1;
  late Animation<double> _breathingAnimation2;
  late Animation<double> _breathingAnimation3;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize multiple breathing controllers for northern lights effect
    _breathingController1 = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _breathingController2 = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _breathingController3 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    
    // Create breathing animations with different curves
    _breathingAnimation1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController1,
      curve: Curves.easeInOut,
    ));
    
    _breathingAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController2,
      curve: Curves.easeInOut,
    ));
    
    _breathingAnimation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _breathingController3,
      curve: Curves.easeInOut,
    ));
    
    // Start all breathing animations
    _breathingController1.repeat(reverse: true);
    _breathingController2.repeat(reverse: true);
    _breathingController3.repeat(reverse: true);
    
    _animationsInitialized = true;
  }

  @override
  void dispose() {
    _breathingController1.dispose();
    _breathingController2.dispose();
    _breathingController3.dispose();
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
                    // Static background gradient (no animation)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF143877).withOpacity(0.15), // Blue at top
                              Color(0xFF1A4A8F).withOpacity(0.2), // Lighter blue in middle
                              Color(0xFF143877).withOpacity(0.15), // Blue
                              Color(0xFF143877).withOpacity(0.1), // Fading out
                              Color(0xFF143877).withOpacity(0.05), // More faded
                              Colors.transparent, // Completely transparent at bottom
                            ],
                            stops: [0.0, 0.3, 0.6, 0.8, 0.9, 1.0],
                          ),
                        ),
                      ),
                    ),
                    
                    // Northern Lights Breathing Effect - Layer 1 (TESTING - HIGH OPACITY)
                    Positioned.fill(
                      child: _animationsInitialized 
                        ? AnimatedBuilder(
                            animation: _breathingAnimation1,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1A4A8F).withOpacity(0.1 + (_breathingAnimation1.value * 0.2)),
                                      Color(0xFF143877).withOpacity(0.05 + (_breathingAnimation1.value * 0.15)),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 0.6, 1.0],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                    ),
                    
                    // Northern Lights Breathing Effect - Layer 2 (TESTING - HIGH OPACITY)
                    Positioned.fill(
                      child: _animationsInitialized 
                        ? AnimatedBuilder(
                            animation: _breathingAnimation2,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.transparent,
                                      Color(0xFF1A4A8F).withOpacity(0.05 + (_breathingAnimation2.value * 0.25)),
                                      Color(0xFF143877).withOpacity(0.1 + (_breathingAnimation2.value * 0.2)),
                                    ],
                                    stops: [0.0, 0.4, 1.0],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                    ),
                    
                    // Northern Lights Breathing Effect - Layer 3 (TESTING - HIGH OPACITY)
                    Positioned.fill(
                      child: _animationsInitialized 
                        ? AnimatedBuilder(
                            animation: _breathingAnimation3,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    center: Alignment.center,
                                    radius: 1.5,
                                    colors: [
                                      Color(0xFF1A4A8F).withOpacity(0.05 + (_breathingAnimation3.value * 0.15)),
                                      Color(0xFF143877).withOpacity(0.03 + (_breathingAnimation3.value * 0.12)),
                                      Colors.transparent,
                                    ],
                                    stops: [0.0, 0.7, 1.0],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
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
                                    onTap: () async {
                                      // Open GitHub profile in new tab
                                      final Uri url = Uri.parse('https://github.com/father-hardstone');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url, mode: LaunchMode.externalApplication);
                                      }
                                    },
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '© 2025 ',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'father-hardstone',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.white.withOpacity(0.7),
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' on GitHub. All rights reserved.',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  onTap: () async {
                                    // Open GitHub profile in new tab
                                    final Uri url = Uri.parse('https://github.com/father-hardstone');
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url, mode: LaunchMode.externalApplication);
                                    }
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '© 2025 ',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'father-hardstone',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' on GitHub. All rights reserved.',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
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
