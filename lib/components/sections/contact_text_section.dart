import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactTextSection extends StatefulWidget {
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
  State<ContactTextSection> createState() => _ContactTextSectionState();
}

class _ContactTextSectionState extends State<ContactTextSection> {
  bool _visible = false;
  List<bool> _elementVisible = List.filled(6, false); // heading, spacer, subheading, spacer, text, social row

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
      offset: _elementVisible[index] ? Offset(0, 0) : const Offset(-0.2, 0),
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
      key: const Key('contact_text_section'),
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
        padding: EdgeInsets.all(widget.isMobile ? 20.0 : 40.0),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widget.isMobile ? double.infinity : 400,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main heading
                _animatedElement(
                  index: 0,
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.isMobile ? 32.0 : 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _animatedElement(
                  index: 1,
                  child: SizedBox(height: widget.isMobile ? 24.0 : 48.0),
                ),

                // Sub heading
                _animatedElement(
                  index: 2,
                  child: Text(
                    "Let's Work Together!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.isMobile ? 20.0 : 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                _animatedElement(
                  index: 3,
                  child: SizedBox(height: widget.isMobile ? 40.0 : 80.0),
                ),

                // Description text
                _animatedElement(
                  index: 4,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Get in touch with us to discuss how we can help your business with our expert IT solutions. You can reach us at ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.isMobile ? 16.0 : 18.0,
                            height: 1.5,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () async {
                              final Uri emailUri = Uri(
                                scheme: 'mailto',
                                path: 'syedibrahimshah067@gmail.com',
                              );
                              if (await canLaunchUrl(emailUri)) {
                                await launchUrl(emailUri);
                              }
                            },
                            child: Text(
                              'syedibrahimshah067@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.isMobile ? 16.0 : 18.0,
                                height: 1.5,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _animatedElement(
                  index: 5,
                  child: Padding(
                    padding: EdgeInsets.only(top: widget.isMobile ? 32.0 : 64.0),
                    child: Row(
                      children: [
                        _buildSocialIcon(Icons.facebook, () async {
                          final Uri url = Uri.parse('https://github.com/father-hardstone');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        }),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.business, () async {
                          final Uri url = Uri.parse('https://github.com/father-hardstone');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        }),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.flutter_dash, () async {
                          final Uri url = Uri.parse('https://github.com/father-hardstone');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        }),
                      ],
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

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
