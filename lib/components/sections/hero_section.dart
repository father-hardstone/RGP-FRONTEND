import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class HeroSection extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const HeroSection({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final containerWidth = constraints.maxWidth;
              final containerHeight = MediaQuery.of(context).size.height;
              
              // Calculate responsive values
              double headingSize = _calculateHeadingSize(containerWidth, containerHeight);
              double textSize = _calculateTextSize(containerWidth, containerHeight);
              double sectionHeight = _calculateSectionHeight(containerWidth, containerHeight);

              return Container(
                width: containerWidth,
                height: sectionHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Empowering\n',
                                style: TextStyle(
                                  fontSize: headingSize,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'Your',
                                style: TextStyle(
                                  fontSize: headingSize,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: ' IT Journey',
                                style: TextStyle(
                                  fontSize: headingSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Unleash the Potential of Cutting-Edge\nIT Solutions and Consultation Services',
                          style: TextStyle(
                            fontSize: textSize,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: PrimaryButton(
                            text: 'Learn More',
                            onPressed: () {
                              scrollHelper.scrollToSection(scrollController, 3); // Learn More
                            },
                            isMobile: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 0.05 * containerWidth,
                    ),
                  ],
                ),
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  double _calculateHeadingSize(double width, double height) {
    const threshold3 = 1400.0;
    if (width >= threshold3) {
      return width * 0.04;
    }
    return 50.0;
  }

  double _calculateTextSize(double width, double height) {
    const threshold3 = 1400.0;
    if (width >= threshold3) {
      return width * 0.018;
    }
    return 20.0;
  }

  double _calculateSectionHeight(double width, double height) {
    const threshold1 = 800.0;
    if (width < threshold1) {
      return 600.0;
    }
    return 0.92 * height;
  }
}
