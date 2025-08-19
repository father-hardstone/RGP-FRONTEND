import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class AboutUsTextSection extends StatelessWidget {
  final double textSize;
  final double headingSize;
  final bool isMobile;

  const AboutUsTextSection({
    super.key,
    required this.textSize,
    required this.headingSize,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/bti7.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 32.0 : 48.0,
            right: isMobile ? 32.0 : 48.0,
            top: isMobile ? 24.0 : 32.0,
            bottom: isMobile ? 24.0 : 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              // Main heading
              Text(
                'About Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: headingSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 32),
              // Sub-heading
              Text(
                'Expert IT Solutions for Your Business',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TypographyConstants.getSubheadingSize(MediaQuery.of(context).size.width),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 40),
              // Body text 1
              Text(
                'At RGP IT Global, we are passionate about technology and its transformative power. Our team of expert consultants and developers work together to provide IT solutions that drive your business forward.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                  height: 1.6,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              // Body text 2
              Text(
                'We understand that every business is unique, which is why we take the time to get to know your business and develop customized solutions that meet your specific needs and provide exponential growth.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
