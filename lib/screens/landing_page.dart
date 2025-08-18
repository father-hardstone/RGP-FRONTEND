import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/app_bars/top_app_bar.dart';
import 'package:rgp_landing_take_3/components/app_bars/main_app_bar.dart';
import 'package:rgp_landing_take_3/components/sections/hero_section.dart';
import 'package:rgp_landing_take_3/components/sections/services_section.dart';
import 'package:rgp_landing_take_3/components/sections/why_choose_us_section.dart';
import 'package:rgp_landing_take_3/components/sections/about_us_section.dart';
import 'package:rgp_landing_take_3/components/sections/contact_section.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollControllerHelper _scrollHelper = ScrollControllerHelper();
  

  


  @override
  void initState() {
    super.initState();
    _scrollHelper.initializeScrollController(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/bti5.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isLargeScreen = constraints.maxWidth >= 1200;
              
              return Scrollbar(
                controller: _scrollController,
                thumbVisibility: isLargeScreen, // Only show on large screens
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    // Top app bar (thin black bar)
                    const TopAppBar(),
                    
                    // Main app bar (blue bar with title and contact button)
                    MainAppBar(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                    
                    // Hero section
                    HeroSection(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                    
                    // Services section
                    const ServicesSection(),
                    
                    // Why choose us section
                    const WhyChooseUsSection(),
                    
                    // About us section
                    const AboutUsSection(),
                    
                    // Contact section
                    ContactSection(
                      scrollController: _scrollController,
                      scrollHelper: _scrollHelper,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
