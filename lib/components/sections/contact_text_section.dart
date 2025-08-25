import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class ContactTextSection extends StatelessWidget {
  final double textSize;
  final double headingSize;
  final bool isMobile;

  const ContactTextSection({
    super.key,
    required this.textSize,
    required this.headingSize,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20.0 : 40.0), // More padding around content
      child: Center( // Center the content
        child: ConstrainedBox( // Constrain content width
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 400, // Limit width on desktop
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main heading
              Text(
                'Contact Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 32.0 : 40.0, // Standard heading size
                  fontWeight: FontWeight.bold,
                ),
              ),
              
                             const SizedBox(height: 48), // Double spacing between heading and subheading
              
              // Sub heading
              Text(
                "Let's Work Together!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 20.0 : 24.0, // Standard subheading size
                  fontWeight: FontWeight.w600,
                ),
              ),
              
                             const SizedBox(height: 80), // Double spacing between subheading and text
              
              // Description text
              Text(
                "Get in touch with us to discuss how we can help your business with our expert IT solutions. You can reach us at operations@rgp-it.com",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 16.0 : 18.0, // Standard text size
                  height: 1.5, // Standard line height
                ),
              ),
              
                             const SizedBox(height: 64), // Double spacing
              
              // Social media icons
              Row(
                children: [
                  _buildSocialIcon(Icons.facebook, () {}),
                  const SizedBox(width: 16), // Standard spacing
                  _buildSocialIcon(Icons.business, () {}), // LinkedIn alternative
                  const SizedBox(width: 16), // Standard spacing
                  _buildSocialIcon(Icons.flutter_dash, () {}), // Twitter/X icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, // Standard icon size
        height: 44, // Standard icon size
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), // Blurred translucent background
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(
          icon,
          color: Colors.white, // Inverted color
          size: 22, // Standard icon size
        ),
      ),
    );
  }
}
