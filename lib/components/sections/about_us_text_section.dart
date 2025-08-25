import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutUsTextSection extends StatefulWidget {
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
  State<AboutUsTextSection> createState() => _AboutUsTextSectionState();
}

class _AboutUsTextSectionState extends State<AboutUsTextSection> {
  bool _visible = false;
  late List<bool> _elementVisible;

  @override
  void initState() {
    super.initState();
    // 6 elements: heading, spacing, subheading, spacing, body1, spacing, body2
    _elementVisible = List.filled(7, false);
  }

  void _animateElements() {
    for (int i = 0; i < _elementVisible.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) setState(() => _elementVisible[i] = true);
      });
    }
  }

  void _hideElements() {
    for (int i = 0; i < _elementVisible.length; i++) {
      if (mounted) setState(() => _elementVisible[i] = false);
    }
  }

  Widget _animatedElement({required Widget child, required int index}) {
    return AnimatedSlide(
      offset: _elementVisible[index] ? Offset.zero : const Offset(-0.2, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _elementVisible[index] ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about_us_text_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_visible) {
          setState(() => _visible = true);
          _animateElements();
        } else if (info.visibleFraction < 0.1 && _visible) {
          setState(() => _visible = false);
          _hideElements();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bti7.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.isMobile ? 32.0 : 48.0,
              right: widget.isMobile ? 32.0 : 48.0,
              top: widget.isMobile ? 24.0 : 32.0,
              bottom: widget.isMobile ? 24.0 : 32.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: widget.isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                // Main heading
                _animatedElement(
                  index: 0,
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.headingSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _animatedElement(
                  index: 1,
                  child: SizedBox(height: widget.isMobile ? 16 : 32),
                ),
                // Sub-heading
                _animatedElement(
                  index: 2,
                  child: Text(
                    'Expert IT Solutions for Your Business',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TypographyConstants.getSubheadingSize(
                          MediaQuery.of(context).size.width),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _animatedElement(
                  index: 3,
                  child: SizedBox(height: widget.isMobile ? 24 : 40),
                ),
                // Body text 1
                _animatedElement(
                  index: 4,
                  child: Text(
                    'At RGP IT Global, we are passionate about technology and its transformative power. Our team of expert consultants and developers work together to provide IT solutions that drive your business forward.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.textSize,
                      height: 1.6,
                    ),
                  ),
                ),
                _animatedElement(
                  index: 5,
                  child: SizedBox(height: widget.isMobile ? 16 : 24),
                ),
                // Body text 2
                _animatedElement(
                  index: 6,
                  child: Text(
                    'We understand that every business is unique, which is why we take the time to get to know your business and develop customized solutions that meet your specific needs and provide exponential growth.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.textSize,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
