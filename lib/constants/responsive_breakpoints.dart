class ResponsiveBreakpoints {
  // Mobile breakpoint
  static const double mobile = 600;
  
  // Tablet breakpoint
  static const double tablet = 900;
  
  // Desktop breakpoint
  static const double desktop = 1200;
  
  // Large desktop breakpoint
  static const double largeDesktop = 1600;
  
  // Check if screen is mobile
  static bool isMobile(double width) => width < mobile;
  
  // Check if screen is tablet
  static bool isTablet(double width) => width >= mobile && width < tablet;
  
  // Check if screen is desktop
  static bool isDesktop(double width) => width >= tablet && width < desktop;
  
  // Check if screen is large desktop
  static bool isLargeDesktop(double width) => width >= desktop;
  
  // Check if screen is small (mobile + tablet)
  static bool isSmall(double width) => width < tablet;
  
  // Check if screen is large (desktop + large desktop)
  static bool isLarge(double width) => width >= tablet;
}
