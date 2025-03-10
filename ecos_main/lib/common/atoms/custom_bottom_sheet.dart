import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.children,
  });

  final List<Widget> children;
  final String title;

  static const double _padding = 12.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(_padding),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border: Border.all(color: Theme.of(context).disabledColor),
          ),
          padding: const EdgeInsets.all(_padding),
          child: Column(children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            ...children
          ]),
        ),
      ),
    );
  }
}
