import 'package:flutter/material.dart';

class AboutUsImageSection extends StatelessWidget {
  final String imagePath;
  final bool isMobile;

  const AboutUsImageSection({
    super.key,
    required this.imagePath,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
