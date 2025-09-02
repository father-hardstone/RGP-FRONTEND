import 'package:flutter/material.dart';

class DemoBanner extends StatefulWidget {
  final Function(bool? isVisible)? onTooltipVisibilityChanged;
  
  const DemoBanner({
    super.key,
    this.onTooltipVisibilityChanged,
  });

  @override
  State<DemoBanner> createState() => _DemoBannerState();
}

class _DemoBannerState extends State<DemoBanner> {
  bool _isHovered = false;
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle tooltip on mobile devices
        setState(() {
          _isClicked = !_isClicked;
        });
        widget.onTooltipVisibilityChanged?.call(_isClicked);
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          widget.onTooltipVisibilityChanged?.call(true);
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          widget.onTooltipVisibilityChanged?.call(false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 80,
            height: 28,
            margin: const EdgeInsets.only(bottom: 10), // Add padding underneath
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blue.withOpacity(0.2),
                  Colors.blueAccent.withOpacity(0.2),
                  Colors.lightBlue.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(4), // More rectangular
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: const Center(
              child: Text(
                'DEMO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
