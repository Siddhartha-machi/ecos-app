import 'package:flutter/material.dart';


import 'package:shared/enums/atoms_enums.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, text, align, padding})
      : _text = text,
        _align = align,
        _padding = padding ?? 0.0;

  final String? _text;
  final DividerAlign? _align;
  final double _padding;

  bool get _enableLeft {
    return _align != DividerAlign.left;
  }

  bool get _enableRight {
    return _align != DividerAlign.right;
  }

  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: _padding),
        child: Row(
          children: [
            if (_enableLeft) const Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.only(
                left: _enableLeft ? 5 : 0,
                right: _enableRight ? 5 : 0,
              ),
              child: Text(_text),
            ),
            if (_enableRight) const Expanded(child: Divider()),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: const Divider(),
    );
  }
}
