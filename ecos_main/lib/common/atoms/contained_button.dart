import 'package:flutter/material.dart';

class ContainedButton extends StatelessWidget {
  const ContainedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.textColor,
    this.fullwidth = true,
  });

  final void Function() onPressed;
  final String label;
  final bool fullwidth;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullwidth ? double.infinity : null,
      height: 45,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all(
              Theme.of(context).buttonTheme.shape as OutlinedBorder?),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
