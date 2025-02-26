import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Buttons, die die Swipe-Bewegung zwischen den Seiten darstellen...
// wird in der StartingPage Klasse verwendet
class PageIndicator extends AnimatedOpacity
{
  final PageController pageController;
  final BuildContext context;

  PageIndicator({
    super.key,
    required super.opacity,  // Sichtbarkeit
    required super.duration, // Dauer der Animation
    required this.pageController, // Page Controller
    required this.context, //Context für Theme
  }) :super(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SmoothPageIndicator(
        controller: pageController,
        count: 4,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: Theme.of(context).colorScheme.onPrimary,
          dotColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    ),
  );
}