import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/about_us_text_section.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection> {
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
              final bool isMobile = width < 768;
              final bool isTablet = width >= 768 && width < 1200;
              
              // Calculate responsive dimensions
              final double sectionHeight = _calculateSectionHeight(width, height, isMobile);
              final double textSize = _calculateTextSize(width, isMobile);
              final double headingSize = _calculateHeadingSize(width, isMobile);

              return Container(
                width: width,
                height: sectionHeight,
                child: isMobile || isTablet
                    ? _buildMobileLayout(width, sectionHeight, textSize, headingSize)
                    : _buildDesktopLayout(width, sectionHeight, textSize, headingSize),
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
        // Text section with background
        Expanded(
          flex: 8,
          child: AboutUsTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: true,
          ),
        ),
        // Image section below text on mobile/tablet
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/aup1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double width, double height, double textSize, double headingSize) {
    return Row(
      children: [
        // Text section with background (50% width)
        Expanded(
          flex: 1,
          child: AboutUsTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: false,
          ),
        ),
        // Image section (50% width)
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/aup1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateSectionHeight(double width, double height, bool isMobile) {
    if (isMobile) {
      return height * 1.1;
    } else if (width < 1200) {
      return height * 0.8;
    } else {
      return height * 0.85;
    }
  }

  double _calculateTextSize(double width, bool isMobile) {
    return TypographyConstants.getBodySize(width);
  }

  double _calculateHeadingSize(double width, bool isMobile) {
    return TypographyConstants.getHeadingSize(width);
  }
}
