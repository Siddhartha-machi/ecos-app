import 'package:flutter/material.dart';

class CustomColorGradient extends StatelessWidget {
  const CustomColorGradient({
    super.key,
    required this.gradientColor,
    required this.child,
    this.padding,
    this.margin,
  });

  final Color gradientColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        gradient: LinearGradient(
          colors: [
            gradientColor.withOpacity(0.55),
            gradientColor.withOpacity(0.8),
            gradientColor.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
