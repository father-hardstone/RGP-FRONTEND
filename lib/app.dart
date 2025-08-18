import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/screens/landing_page.dart';

class RgpApp extends StatelessWidget {
  const RgpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGP IT Global',
      home: const LandingPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.resolveWith<bool>((states) {
            // Show scrollbar only on larger screens (desktop)
            // Hide on tablet and smaller screens
            return false; // We'll handle visibility per-screen in the landing page
          }),
          thumbColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
