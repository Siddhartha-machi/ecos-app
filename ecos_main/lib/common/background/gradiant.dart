import 'package:flutter/material.dart';

class Gradiant extends StatelessWidget {
  const Gradiant({required this.child, this.padding, super.key});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.onPrimaryContainer,
              Theme.of(context).colorScheme.onPrimaryContainer,
              Theme.of(context).colorScheme.onPrimary,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: child,
      ),
    );
  }
}
