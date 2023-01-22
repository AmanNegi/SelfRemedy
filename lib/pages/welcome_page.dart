import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/pages/auth/signup_page.dart';
import '../painters/welcome_painter.dart';

class WelcomePage extends StatefulWidget {
  static const String route = "/WelcomePage";

  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation buttonAnimation,
      textAnimation,
      painterAnimation,
      positionAnimation,
      fadeTextAnimation;

  late double height, width;
  bool showWelcomeText = false;

  @override
  void initState() {
    initializeAnimations();
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  void initializeAnimations() {
    controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2, milliseconds: 500));

    painterAnimation =
        Tween<double>(begin: 0.0, end: 12.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.5, curve: Curves.easeInOut),
    ));

    textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
    ));

    positionAnimation =
        Tween<double>(begin: 0.5, end: 0.3).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.625, 0.7, curve: Curves.easeInOut),
    ));

    fadeTextAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.7, 0.8, curve: Curves.easeInOut),
    ));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              height: 150,
              width: 150,
              'assets/loading.gif',
            ),
          ),
          CustomPaint(
            painter: WelcomePainter(painterAnimation.value),
            child: Stack(
              children: [
                textAnimation.value > 0.0 ? _buildWelcomeText() : Container(),
                fadeTextAnimation.value > 0
                    ? _buildDetailTextAndButton(context)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDetailTextAndButton(BuildContext context) {
    return Positioned(
      top: 0.425 * height,
      left: 0.1 * width,
      right: 0.1 * width,
      child: Opacity(
        opacity: fadeTextAnimation.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Wikipedia for self help",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.05 * height),
            GestureDetector(
              onTap: () {
                controller.reverse().then((value) {
                  goToPage(context, const SignUpPage());
                });
              },
              child: Container(
                height: 0.055 * height,
                width: 0.45 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.25)),
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildWelcomeText() {
    return Positioned(
      top: positionAnimation.value * (height),
      left: 0,
      right: 0,
      child: Opacity(
        opacity: textAnimation.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/leaf.svg",
              height: 50,
              width: 50,
            ),
            Container(
              child: const Center(
                child: Text(
                  "Self Remedy",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
