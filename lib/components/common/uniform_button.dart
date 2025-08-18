import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class UniformButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isMobile;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool isLoading;

  const UniformButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isMobile = false,
    this.width,
    this.height,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double buttonWidth = width ?? constraints.maxWidth;
        final double buttonHeight = height ?? (isMobile ? 44.0 : 48.0);
        final double fontSize = TypographyConstants.getBodySize(buttonWidth) * 0.9;
        
        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              foregroundColor: isPrimary 
                  ? Colors.white
                  : Colors.white.withOpacity(0.9),
              side: BorderSide(
                color: isPrimary 
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.5),
                width: isPrimary ? 1.0 : 1.5,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20.0 : 24.0,
                vertical: isMobile ? 10.0 : 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isPrimary ? Colors.white : Colors.white.withOpacity(0.9),
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: fontSize * 1.1,
                          color: isPrimary 
                              ? Colors.white
                              : Colors.white.withOpacity(0.9),
                        ),
                        SizedBox(width: isMobile ? 8.0 : 12.0),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

// Convenience constructors for common button types
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isMobile;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isMobile = false,
    this.width,
    this.height,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return UniformButton(
      text: text,
      onPressed: onPressed,
      isPrimary: true,
      isMobile: isMobile,
      width: width,
      height: height,
      icon: icon,
      isLoading: isLoading,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isMobile;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool isLoading;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isMobile = false,
    this.width,
    this.height,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return UniformButton(
      text: text,
      onPressed: onPressed,
      isPrimary: false,
      isMobile: isMobile,
      width: width,
      height: height,
      icon: icon,
      isLoading: isLoading,
    );
  }
}
