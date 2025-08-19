import 'package:flutter/material.dart';

class ServicesCardAnimations {
  // Animation controllers for each card
  late AnimationController cardController;
  late AnimationController imageController;
  late AnimationController titleController;
  late AnimationController textController;
  late AnimationController buttonController;
  
  // Animations for each card
  late Animation<double> cardFadeAnimation;
  late Animation<Offset> cardSlideAnimation;
  late Animation<double> imageFadeAnimation;
  late Animation<double> imageScaleAnimation;
  late Animation<double> titleFadeAnimation;
  late Animation<Offset> titleSlideAnimation;
  late Animation<double> textFadeAnimation;
  late Animation<Offset> textSlideAnimation;
  late Animation<double> buttonFadeAnimation;
  late Animation<Offset> buttonSlideAnimation;
  
  ServicesCardAnimations({
    required TickerProvider vsync,
    required int cardIndex,
  }) {
    _initializeControllers(vsync, cardIndex);
    _initializeAnimations();
  }
  
  void _initializeControllers(TickerProvider vsync, int cardIndex) {
    // Progressive duration increase: top-left = fast, bottom-right = slow
    // Reduced 200ms from each base duration for snappier feel
    final int cardIndexDeltaMs = cardIndex * 300; // +300ms per subsequent card

    final int cardMs = 1000 + cardIndexDeltaMs;      // Base: 1000ms, then 1300ms, 1600ms
    final int imageMs = 1050 + cardIndexDeltaMs;     // Base: 1050ms, then 1350ms, 1650ms
    final int titleMs = 1100 + cardIndexDeltaMs;     // Base: 1100ms, then 1400ms, 1700ms
    final int textMs = 1150 + cardIndexDeltaMs;      // Base: 1150ms, then 1450ms, 1750ms
    final int buttonMs = 1200 + cardIndexDeltaMs;    // Base: 1200ms, then 1500ms, 1800ms
    
    cardController = AnimationController(
      duration: Duration(milliseconds: cardMs),
      vsync: vsync,
    );
    
    imageController = AnimationController(
      duration: Duration(milliseconds: imageMs),
      vsync: vsync,
    );
    
    titleController = AnimationController(
      duration: Duration(milliseconds: titleMs),
      vsync: vsync,
    );
    
    textController = AnimationController(
      duration: Duration(milliseconds: textMs),
      vsync: vsync,
    );
    
    buttonController = AnimationController(
      duration: Duration(milliseconds: buttonMs),
      vsync: vsync,
    );
  }
  
  void _initializeAnimations() {
    cardFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: cardController,
      curve: Curves.easeOut,
    ));
    
    cardSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.08, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: cardController,
      curve: Curves.easeOut,
    ));
    
    imageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: imageController,
      curve: Curves.easeOut,
    ));
    
    imageScaleAnimation = Tween<double>(
      begin: 1.2,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: imageController,
      curve: Curves.easeOut,
    ));
    
    titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: titleController,
      curve: Curves.easeOut,
    ));
    
    titleSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.05, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: titleController,
      curve: Curves.easeOut,
    ));
    
    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Curves.easeOut,
    ));
    
    textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.04, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Curves.easeOut,
    ));
    
    buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeOut,
    ));
    
    buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.03, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeOut,
    ));
  }
  
  void startAnimations() {
    // All animations start simultaneously but with different durations
    cardController.forward();
    imageController.forward();
    titleController.forward();
    textController.forward();
    buttonController.forward();
  }
  
  void resetAnimations() {
    cardController.reset();
    imageController.reset();
    titleController.reset();
    textController.reset();
    buttonController.reset();
  }
  
  void dispose() {
    cardController.dispose();
    imageController.dispose();
    titleController.dispose();
    textController.dispose();
    buttonController.dispose();
  }
}
