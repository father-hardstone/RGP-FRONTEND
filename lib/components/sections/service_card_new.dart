import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class ServiceCardNew extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback? onDetailsPressed;
  final bool isMobile;
  
  // Animation parameters
  final Animation<double>? imageFadeAnimation;
  final Animation<double>? imageScaleAnimation;
  final Animation<double>? titleFadeAnimation;
  final Animation<double>? textFadeAnimation;
  final Animation<double>? buttonFadeAnimation;

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
    this.textFadeAnimation,
    this.buttonFadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double cardHeight = isMobile ? 600 : 550;
        
        return Container(
          width: width,
          height: cardHeight,
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 24.0,
            vertical: isMobile ? 12.0 : 16.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Background image with animations and reduced opacity
                Positioned.fill(
                  child: imageScaleAnimation != null && imageFadeAnimation != null
                      ? AnimatedBuilder(
                          animation: Listenable.merge([imageScaleAnimation!, imageFadeAnimation!]),
                          builder: (context, child) {
                            return Transform.scale(
                              scale: imageScaleAnimation!.value,
                              child: Opacity(
                                opacity: imageFadeAnimation!.value * 0.6, // Reduced opacity to 60%
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        )
                      : Opacity(
                          opacity: 0.6, // Default reduced opacity
                          child: Image.asset(
                            imagePath,
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
                       padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
                       child: titleFadeAnimation != null
                           ? FadeTransition(
                               opacity: titleFadeAnimation!,
                               child: Text(
                                 title,
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: TypographyConstants.getSubheadingSize(width),
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             )
                           : Text(
                               title,
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
                       padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           // Description with animation
                           textFadeAnimation != null
                               ? FadeTransition(
                                   opacity: textFadeAnimation!,
                                   child: Text(
                                     description,
                                     style: TextStyle(
                                       color: Colors.white.withOpacity(0.9),
                                       fontSize: TypographyConstants.getBodySize(width),
                                       height: isMobile ? 1.3 : 1.4,
                                     ),
                                   ),
                                 )
                               : Text(
                                   description,
                                   style: TextStyle(
                                     color: Colors.white.withOpacity(0.9),
                                     fontSize: TypographyConstants.getBodySize(width),
                                     height: isMobile ? 1.3 : 1.4,
                                   ),
                                 ),
                           SizedBox(height: isMobile ? 12.0 : 20.0),
                           // Details button with animation
                           if (onDetailsPressed != null)
                             buttonFadeAnimation != null
                                 ? FadeTransition(
                                     opacity: buttonFadeAnimation!,
                                     child: PrimaryButton(
                                       text: 'Learn More',
                                       onPressed: onDetailsPressed,
                                       isMobile: isMobile,
                                     ),
                                   )
                                 : PrimaryButton(
                                     text: 'Learn More',
                                     onPressed: onDetailsPressed,
                                     isMobile: isMobile,
                                   ),
                         ],
                       ),
                     ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
