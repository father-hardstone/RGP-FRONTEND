import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class MainAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const MainAppBar({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> with TickerProviderStateMixin {
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      duration: const Duration(seconds: 5), // sweep speed
      vsync: this,
    )..repeat(); // continuous one-way loop
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      snap: false,
      floating: false,
      toolbarHeight: 70,
      collapsedHeight: 70.0,
      expandedHeight: 70.0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Minimal blur for true translucency
          child: AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF143877).withOpacity(0.23), // Made lighter (increased from 0.15)
                      Color(0xFF1A4A8F).withOpacity(0.29), // Made darker (reduced from 0.65)
                      Color(0xFF1A4A8F).withOpacity(0.30), // Made darker (reduced from 0.65)
                      Color(0xFF1A4A8F).withOpacity(0.29), // Made darker (reduced from 0.65)
                      Color(0xFF143877).withOpacity(0.23), // Made lighter (increased from 0.15)
                      
                    ],
                    stops: [
                      0.05, // Moved from 0.2 - expand lighter end
                      0.2,  // Keep center
                      0.4,  // Keep center
                      0.6,  // Keep center
                      0.95, // Moved from 0.8 - expand lighter end
                    ],
                    // Apply a shifting transform to simulate sweep
                    transform: GradientRotation(
                      _gradientController.value * 2 * 3.14159, // Full rotation for smooth sweep
                    ),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.biggest.height * 0.35; // Bigger font
                    return Stack(
                      children: [
                        // Company name on the left side
                        Positioned(
                          left: 16.0, // Left padding to match Contact Us button
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: LayoutBuilder(
                              builder: (context, titleConstraints) {
                                // Responsive text based on screen width
                                final screenWidth = MediaQuery.of(context).size.width;
                                final displayText = screenWidth < 800 ? 'RGP' : 'RGP IT GLOBAL';
                                
                                return GestureDetector(
                                  onTap: () {
                                    // Scroll to top of the page
                                    widget.scrollController.animateTo(
                                      0,
                                      duration: const Duration(milliseconds: 800),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: Colors.transparent,
                                      ),
                                      child: Text(
                                        displayText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 6,
                                              color: Colors.black.withOpacity(0.7),
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
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
                  },
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 180,
            height: 44,
            child: Center(
              child: PrimaryButton(
                text: 'Contact Us',
                onPressed: () {
                  widget.scrollHelper.scrollToSection(
                    widget.scrollController,
                    2,
                  );
                },
                isMobile: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
