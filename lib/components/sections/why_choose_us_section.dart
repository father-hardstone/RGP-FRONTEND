import 'package:flutter/material.dart';
import 'dart:async';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';

class WhyChooseUsSection extends StatefulWidget {
	const WhyChooseUsSection({super.key});

	@override
	State<WhyChooseUsSection> createState() => _WhyChooseUsSectionState();
}

class _WhyChooseUsSectionState extends State<WhyChooseUsSection>
		with TickerProviderStateMixin {
	late AnimationController _fadeController;
	late AnimationController _typingController;
	late AnimationController _cursorController;
	late Animation<double> _fadeAnimation;
	
	bool _isVisible = false;
	bool _headingVisible = false;
	bool _subtextVisible = false;
	bool _numbersVisible = false;
	
	final List<String> _finalNumbers = ['5', '25+', '100+', '10'];
	final List<String> _labels = ['Years of Experience', 'Expert Consultants', 'Projects Completed', 'Industry Partners'];
	
	List<String> _displayedNumbers = ['', '', '', ''];
	int _currentTypingIndex = 0;
	int _currentCharIndex = 0;
	bool _cursorVisible = true;
	
	Timer? _typingTimer;
	Timer? _cursorTimer;

	@override
	void initState() {
		super.initState();
		_fadeController = AnimationController(
			duration: const Duration(milliseconds: 800),
			vsync: this,
		);
		
		_typingController = AnimationController(
			duration: const Duration(milliseconds: 2000),
			vsync: this,
		);
		
		_cursorController = AnimationController(
			duration: const Duration(milliseconds: 500),
			vsync: this,
		);
		
		_fadeAnimation = Tween<double>(
			begin: 0.0,
			end: 1.0,
		).animate(CurvedAnimation(
			parent: _fadeController,
			curve: Curves.easeOut,
		));
		
		// Start cursor blinking
		_startCursorBlinking();
	}

	@override
	void dispose() {
		_fadeController.dispose();
		_typingController.dispose();
		_cursorController.dispose();
		_typingTimer?.cancel();
		_cursorTimer?.cancel();
		super.dispose();
	}

	void _startCursorBlinking() {
		_cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
			if (mounted) {
				setState(() {
					_cursorVisible = !_cursorVisible;
				});
			}
		});
	}

	void _onVisibilityChanged(VisibilityInfo info) {
		if (info.visibleFraction > 0.3) { // Section is more than 30% visible
			if (!_isVisible) {
				_onSectionVisible();
			}
		} else { // Section is less than 30% visible
			if (_isVisible) {
				_onSectionHidden();
			}
		}
	}

	void _onSectionVisible() {
		setState(() {
			_isVisible = true;
			_headingVisible = false;
			_subtextVisible = false;
			_numbersVisible = false;
			_displayedNumbers = ['', '', '', ''];
			_currentTypingIndex = 0;
			_currentCharIndex = 0;
		});
		
		// Reset animations
		_fadeController.reset();
		_typingController.reset();
		
		// Start the sequence: heading → subtext → numbers
		_startAnimationSequence();
	}

	void _onSectionHidden() {
		setState(() {
			_isVisible = false;
			_headingVisible = false; // triggers fade-out
			_subtextVisible = false; // triggers fade-out
			_numbersVisible = false; // triggers fade-out
		});
		
		// Stop typing immediately
		_typingTimer?.cancel();
		
		// After fade-out completes, clear numbers so next time starts fresh
		Future.delayed(const Duration(milliseconds: 250), () {
			if (!mounted || _isVisible) return; // if section became visible again, skip clearing
			setState(() {
				_displayedNumbers = ['', '', '', ''];
				_currentTypingIndex = 0;
				_currentCharIndex = 0;
			});
		});
	}

	void _startAnimationSequence() {
		// Step 1: Show heading
		Future.delayed(const Duration(milliseconds: 150), () {
			if (mounted && _isVisible) {
				setState(() {
					_headingVisible = true;
				});
				_fadeController.forward();
				
				// Step 2: Show subtext after heading fades in
				Future.delayed(const Duration(milliseconds: 250), () {
					if (mounted && _isVisible) {
						setState(() {
							_subtextVisible = true;
						});
						
						// Step 3: Start typing numbers after subtext appears
						Future.delayed(const Duration(milliseconds: 200), () {
							if (mounted && _isVisible) {
								setState(() {
									_numbersVisible = true;
								});
								_startTypingNumbers();
							}
						});
					}
				});
			}
		});
	}

	void _startTypingNumbers() {
		_typingTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
			if (!mounted || !_isVisible) {
				timer.cancel();
				return;
			}
			
			setState(() {
				if (_currentCharIndex < _finalNumbers[_currentTypingIndex].length) {
					// Add next character
					_displayedNumbers[_currentTypingIndex] = _finalNumbers[_currentTypingIndex]
						.substring(0, _currentCharIndex + 1);
					_currentCharIndex++;
				} else {
					// Move to next number
					_currentTypingIndex++;
					_currentCharIndex = 0;
					
					if (_currentTypingIndex >= _finalNumbers.length) {
						// All numbers typed, stop timer
						timer.cancel();
						return;
					}
				}
			});
		});
	}

	@override
	Widget build(BuildContext context) {
		return SliverList(
			delegate: SliverChildBuilderDelegate(
				(BuildContext context, int index) {
					return LayoutBuilder(
						builder: (context, constraints) {
							final double width = constraints.maxWidth;
							final double height = MediaQuery.of(context).size.height;
							final bool isMobile = width < 700;

							final double sectionHeight = isMobile
									? 900
									: (height * 0.5).clamp(500.0, 700.0); // Reduced from 0.7 to 0.5 and max from 900 to 700
							final double headingSize = TypographyConstants.getHeadingSize(width);
							final double numberSize = TypographyConstants.getNumberSize(width);
							final double textSize = TypographyConstants.getBodySize(width);

							return VisibilityDetector(
								key: const Key('why_choose_us_section'),
								onVisibilityChanged: _onVisibilityChanged,
								child: Container(
									color: const Color.fromARGB(0, 33, 149, 243),
									width: width,
									height: sectionHeight,
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.center,
										children: [
											SizedBox(height: isMobile ? sectionHeight * 0.09 : sectionHeight * 0.12),
											
											// Heading with faster fade-in/out
											AnimatedOpacity(
												opacity: _headingVisible ? 1.0 : 0.0,
												duration: const Duration(milliseconds: 250),
												child: AnimatedSlide(
													offset: _headingVisible ? Offset.zero : const Offset(0, -0.2),
													duration: const Duration(milliseconds: 250),
													curve: Curves.easeOut,
													child: Text(
														'Why Choose Us',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Colors.white,
															fontSize: headingSize,
															fontWeight: FontWeight.bold,
														),
													),
												),
											),
											
											SizedBox(height: isMobile ? sectionHeight * 0.025 : sectionHeight * 0.12),
											
											// Stats with typing animation - always built, fade in/out quickly
											AnimatedOpacity(
												opacity: _numbersVisible ? 1.0 : 0.0,
												duration: const Duration(milliseconds: 250),
												child: AnimatedSlide(
													offset: _numbersVisible ? Offset.zero : const Offset(0, 0.1),
													duration: const Duration(milliseconds: 250),
													curve: Curves.easeOut,
													child: isMobile
														? Column(
															crossAxisAlignment: CrossAxisAlignment.stretch,
															children: _buildStatItems(numberSize, textSize, width, sectionHeight, isMobile),
														)
														: Row(
															mainAxisAlignment: MainAxisAlignment.spaceEvenly,
															children: _buildStatItems(numberSize, textSize, width, sectionHeight, isMobile),
														),
												),
											),
										],
									),
								),
							);
					},
				);
			},
			childCount: 1,
		),
		);
	}

	List<Widget> _buildStatItems(
		double numberSize,
		double textSize,
		double width,
		double sectionHeight,
		bool isMobile,
	) {
		Widget stat(int index, String number, String label) {
			return Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					// Number with typing effect and blinking cursor
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(
								_displayedNumbers[index],
								textAlign: TextAlign.center,
								style: TextStyle(
									color: Colors.white,
									fontSize: numberSize,
									fontWeight: FontWeight.bold,
									fontFamily: 'monospace', // Terminal font
								),
							),
							// Blinking cursor (white)
							if (_currentTypingIndex == index && _cursorVisible)
								Container(
									width: 3,
									height: numberSize * 0.8,
									margin: const EdgeInsets.only(left: 2),
									decoration: BoxDecoration(
										color: Colors.white,
										borderRadius: BorderRadius.circular(1),
									),
								),
						],
					),
					
					// Label with faster fade-in/out
					AnimatedOpacity(
						opacity: _subtextVisible ? 1.0 : 0.0,
						duration: const Duration(milliseconds: 250),
						child: AnimatedSlide(
							offset: _subtextVisible ? Offset.zero : const Offset(0, -0.1),
							duration: const Duration(milliseconds: 250),
							curve: Curves.easeOut,
							child: Container(
								width: isMobile ? width * 0.8 : width * 0.2,
								padding: EdgeInsets.symmetric(
									horizontal: isMobile ? 8.0 : 4.0,
									vertical: isMobile ? 8.0 : 4.0,
								),
								child: Text(
									label,
									textAlign: TextAlign.center,
									style: TextStyle(
										color: Colors.white,
										fontSize: textSize,
									),
								),
							),
						),
					),
					
					SizedBox(height: isMobile ? 16.0 : 24.0),
				],
			);
		}

		return [
			stat(0, '5', 'Years of Experience'),
			stat(1, '25+', 'Expert Consultants'),
			stat(2, '100+', 'Projects Completed'),
			stat(3, '10', 'Industry Partners'),
		];
	}
}
