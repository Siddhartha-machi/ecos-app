import 'package:flutter/material.dart';

class BeatAnimation extends StatefulWidget {
  const BeatAnimation({
    super.key,
    required this.child,
    this.scaleUp = 1.0,
    this.scaleDown = 0.9,
  });

  final Widget child;
  final double scaleUp;
  final double scaleDown;

  @override
  State<BeatAnimation> createState() => _BeatAnimation();
}

class _BeatAnimation extends State<BeatAnimation> {
  bool _isScaledDown = true;

  @override
  void initState() {
    super.initState();
    _startAnimationLoop(); // Start the animation loop
  }

  void _startAnimationLoop() async {
    while (mounted) {
      setState(() {
        _isScaledDown = !_isScaledDown;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isScaledDown ? widget.scaleUp : widget.scaleDown,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
