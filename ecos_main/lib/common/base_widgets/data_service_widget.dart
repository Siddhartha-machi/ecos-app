import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DataConsumerWidget<T> extends ConsumerWidget {
  final StateNotifierProvider<StateNotifier<AsyncValue<List<T>>>,
      AsyncValue<List<T>>> provider;

  const DataConsumerWidget({required this.provider, super.key});

  Widget renderUI(BuildContext context, dynamic data, WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (data) => renderUI(context, data, ref),
    );
  }
}
