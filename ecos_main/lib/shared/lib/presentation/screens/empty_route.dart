import 'package:flutter/material.dart';

class EmptyRoute extends StatelessWidget {
  final String path;
  const EmptyRoute(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'No builder provided for path "$path"',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
