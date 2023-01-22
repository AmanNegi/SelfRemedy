import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_remedy/globals.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/leaf.svg",
                color: accentColor,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(height: 20),
            const Chip(
              backgroundColor: accentColor,
              label: Text(
                "Self-Remedy",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "The purpose of the self-remedy application is to provide users with information and tools to help them diagnose and treat common health issues independently.\n\nAt the same time, it also helps share with users their knowledge about a health issue. While it works towards improving health, it also acts as an educational and informational app.",
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
