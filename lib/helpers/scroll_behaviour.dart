import 'package:flutter/material.dart';

// Helps to hide the glow effect on overscroll

class HideGlowScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
