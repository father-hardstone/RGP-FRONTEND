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
  late Animation<double> imageFadeAnimation;
  late Animation<double> imageScaleAnimation;
  late Animation<double> titleFadeAnimation;
  late Animation<double> textFadeAnimation;
  late Animation<double> buttonFadeAnimation;
  
  ServicesCardAnimations({
    required TickerProvider vsync,
    required int cardIndex,
  }) {
    _initializeControllers(vsync, cardIndex);
    _initializeAnimations();
  }
  
  void _initializeControllers(TickerProvider vsync, int cardIndex) {
    // Stagger the card appearance based on index
    final int cardDelay = cardIndex * 50; // 50ms delay between cards
    
    cardController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: vsync,
    );
    
    imageController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: vsync,
    );
    
    titleController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: vsync,
    );
    
    textController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: vsync,
    );
    
    buttonController = AnimationController(
      duration: const Duration(milliseconds: 80),
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
    
    imageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: imageController,
      curve: Curves.easeOut,
    ));
    
    imageScaleAnimation = Tween<double>(
      begin: 1.2, // Start 20% larger
      end: 1.0, // End at normal size
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
    
    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
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
  }
  
  void startAnimations() {
    // Start card container animation
    cardController.forward();
    
    // Start image animation immediately
    imageController.forward();
    
    // Stagger the other elements
    Future.delayed(const Duration(milliseconds: 100), () {
      titleController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 200), () {
      textController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 300), () {
      buttonController.forward();
    });
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
