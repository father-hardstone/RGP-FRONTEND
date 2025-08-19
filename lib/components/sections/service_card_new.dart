import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class ServiceCardNew extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback? onDetailsPressed;
  final bool isMobile;
  
  // Animation parameters
  final Animation<double>? imageFadeAnimation;
  final Animation<double>? imageScaleAnimation;
  final Animation<double>? titleFadeAnimation;
  final Animation<Offset>? titleSlideAnimation;
  final Animation<double>? textFadeAnimation;
  final Animation<Offset>? textSlideAnimation;
  final Animation<double>? buttonFadeAnimation;
  final Animation<Offset>? buttonSlideAnimation;

  const ServiceCardNew({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onDetailsPressed,
    required this.isMobile,
    this.imageFadeAnimation,
    this.imageScaleAnimation,
    this.titleFadeAnimation,
    this.titleSlideAnimation,
    this.textFadeAnimation,
    this.textSlideAnimation,
    this.buttonFadeAnimation,
    this.buttonSlideAnimation,
  });

  @override
  State<ServiceCardNew> createState() => _ServiceCardNewState();
}

class _ServiceCardNewState extends State<ServiceCardNew> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double cardHeight = widget.isMobile ? 600 : 550;
        
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: width,
            height: width < 600 ? 700 : // Mobile screens
                   width < 900 ? 725 : // Tablet screens (fix overflow)
                   width < 1200 ? 675 : // Small laptop screens
                   550, // Large laptop and desktop screens
            margin: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 16.0 : 24.0,
              vertical: widget.isMobile ? 12.0 : 16.0,
            ),
            transform: _isHovered 
                ? Matrix4.translationValues(0, -8, 0) // Lift up by 8px
                : Matrix4.translationValues(0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isHovered 
                      ? Colors.black.withOpacity(0.4) // Enhanced shadow on hover
                      : Colors.black.withOpacity(0.3),
                  blurRadius: _isHovered ? 15 : 10, // Increased blur on hover
                  offset: _isHovered 
                      ? const Offset(0, 8) // Enhanced offset on hover
                      : const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Background image with animations and reduced brightness
                  Positioned.fill(
                    child: widget.imageScaleAnimation != null && widget.imageFadeAnimation != null
                        ? AnimatedBuilder(
                            animation: Listenable.merge([widget.imageScaleAnimation!, widget.imageFadeAnimation!]),
                            builder: (context, child) {
                              return Transform.scale(
                                scale: widget.imageScaleAnimation!.value,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.matrix([
                                    0.8, 0, 0, 0, 0,  // Reduce brightness to 80%
                                    0, 0.8, 0, 0, 0,
                                    0, 0, 0.8, 0, 0,
                                    0, 0, 0, 1, 0,
                                  ]),
                                  child: Image.asset(
                                    widget.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          )
                        : ColorFiltered(
                            colorFilter: ColorFilter.matrix([
                              0.8, 0, 0, 0, 0,  // Default reduced brightness to 80%
                              0, 0.8, 0, 0, 0,
                              0, 0, 0.8, 0, 0,
                              0, 0, 0, 1, 0,
                            ]),
                            child: Image.asset(
                              widget.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  // Gradient overlay for better text readability
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Content - Title at top, description and button at bottom
                  Column(
                    children: [
                      // Title at the top - left indented with animation
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(widget.isMobile ? 16.0 : 28.0),
                        child: widget.titleFadeAnimation != null && widget.titleSlideAnimation != null
                            ? SlideTransition(
                                position: widget.titleSlideAnimation!,
                                child: FadeTransition(
                                    opacity: widget.titleFadeAnimation!,
                                    child: Text(
                                      widget.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: TypographyConstants.getSubheadingSize(width),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              )
                            : Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TypographyConstants.getSubheadingSize(width),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      
                      // Spacer to push description and button to bottom
                      const Spacer(),
                      
                      // Description and button at the bottom - left indented
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(widget.isMobile ? 16.0 : 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Description with animation
                            widget.textFadeAnimation != null && widget.textSlideAnimation != null
                                ? SlideTransition(
                                    position: widget.textSlideAnimation!,
                                    child: FadeTransition(
                                        opacity: widget.textFadeAnimation!,
                                        child: Text(
                                          widget.description,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: TypographyConstants.getBodySize(width),
                                            height: widget.isMobile ? 1.3 : 1.4,
                                          ),
                                        ),
                                      ),
                                  )
                                : Text(
                                    widget.description,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: TypographyConstants.getBodySize(width),
                                      height: widget.isMobile ? 1.3 : 1.4,
                                    ),
                                  ),
                            SizedBox(height: widget.isMobile ? 12.0 : 20.0),
                            // Details button with animation
                            if (widget.onDetailsPressed != null)
                              widget.buttonFadeAnimation != null && widget.buttonSlideAnimation != null
                                  ? SlideTransition(
                                      position: widget.buttonSlideAnimation!,
                                      child: FadeTransition(
                                          opacity: widget.buttonFadeAnimation!,
                                          child: PrimaryButton(
                                            text: 'Learn More',
                                            onPressed: widget.onDetailsPressed,
                                            isMobile: widget.isMobile,
                                          ),
                                        ),
                                    )
                                  : PrimaryButton(
                                      text: 'Learn More',
                                      onPressed: widget.onDetailsPressed,
                                      isMobile: widget.isMobile,
                                    ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
