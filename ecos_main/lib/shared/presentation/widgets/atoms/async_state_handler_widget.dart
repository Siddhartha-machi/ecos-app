import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncStateHandlerWidget<T> extends StatelessWidget {
  final AsyncValue<T> state;
  final Widget Function(T) renderUI;

  const AsyncStateHandlerWidget({
    required this.state,
    required this.renderUI,
    super.key,
  });

  Widget _loader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _errorWidget(error, stackTrace) {
    return Center(child: Text('Error: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: renderUI,
      loading: _loader,
      error: _errorWidget,
    );
  }
}
