import 'package:flutter/material.dart';

class AboutUsImageSection extends StatelessWidget {
  final String imagePath;
  final bool isMobile;
  final Animation<double>? zoomAnimation;

  const AboutUsImageSection({
    super.key,
    required this.imagePath,
    required this.isMobile,
    this.zoomAnimation,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );

    if (zoomAnimation != null) {
      return AnimatedBuilder(
        animation: zoomAnimation!,
        builder: (context, child) {
          return ClipRect(
            child: Transform.scale(
              scale: zoomAnimation!.value,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: imageWidget,
              ),
            ),
          );
        },
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: imageWidget,
    );
  }
}
