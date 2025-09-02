import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';
import 'package:rgp_landing_take_3/components/common/demo_banner.dart';


class MainAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;
  final Function(bool? isVisible)? onDemoTooltipVisibilityChanged;

  const MainAppBar({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
    this.onDemoTooltipVisibilityChanged,
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
      toolbarHeight: 85,
      collapsedHeight: 85.0,
      expandedHeight: 85.0,
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
                        // Company logo on the left side
                        Positioned(
                          left: 16.0, // Left padding to match Contact Us button
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: LayoutBuilder(
                              builder: (context, titleConstraints) {
                                // Responsive logo based on screen width
                                final screenWidth = MediaQuery.of(context).size.width;
                                final isMobile = screenWidth < 800;
                                
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
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0), // Increased horizontal padding
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end, // Align items to bottom
                                        children: [
                                          Image.asset(
                                            isMobile 
                                              ? 'assets/icons/RGP GLOBAL-IT- mobile.png'
                                              : 'assets/icons/RGP GLOBAL-IT.png',
                                            height: isMobile ? fontSize * 2.5 : fontSize * 4.0, // Significantly increased to prevent pixelation
                                            width: isMobile ? fontSize * 3.5 : fontSize * 6.0, // Proportionally increased width
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(width: 16), // Space between logo and demo banner
                                          DemoBanner(
                                            onTooltipVisibilityChanged: widget.onDemoTooltipVisibilityChanged,
                                          ),
                                        ],
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
                  // Ensure page lengths are calculated before scrolling
                  if (widget.scrollHelper.pl1 == 0) {
                    // Recalculate page lengths if not done
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        widget.scrollHelper.calculatePageLengths(context);
                        widget.scrollHelper.scrollToSection(
                          widget.scrollController,
                          2,
                        );
                      }
                    });
                  } else {
                    // Use existing calculated lengths
                    widget.scrollHelper.scrollToSection(
                      widget.scrollController,
                      2,
                    );
                  }
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
