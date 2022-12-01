import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';

class LogoHero extends StatelessWidget {
  final double height;
  const LogoHero({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: kHeroLogoTag,
      child: SizedBox(
        height: height,
        child: Image.asset('images/logo512white.png'),
      ),
    );
  }
}
