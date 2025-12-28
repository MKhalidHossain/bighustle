import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;

  const AppLogo({
    super.key,
    this.height = 150,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/logo.png',
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}



class Habit extends StatelessWidget {
  final double height;
  final double width;

  const Habit({
    super.key,
    this.height = 50,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Icons/chat.png',
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
