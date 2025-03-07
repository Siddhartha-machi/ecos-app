import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/repositories/extension_data_service.dart';

class ExtensionNotifier extends StateNotifier<AsyncValue<List<Extension>>> {
  final ExtensionDataService extensionService;

  ExtensionNotifier(this.extensionService) : super(const AsyncValue.loading()) {
    fetchExtensions();
  }

  Future<void> fetchExtensions() async {
    state = const AsyncValue.loading();
    try {
      final extension = await extensionService.fetchAll();
      state = AsyncValue.data(extension);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createExtension(Extension extension) async {
    try {
      final newExtension = await extensionService.createItem(extension);
      state = AsyncValue.data([...state.value ?? [], newExtension]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateExtension(String id, Extension extension) async {
    try {
      final updatedExtension = await extensionService.updateItem(id, extension);
      state = AsyncValue.data(
        state.value!.map((e) => e.id == id ? updatedExtension : e).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteExtension(String id) async {
    try {
      final success = await extensionService.deleteItem(id);
      if (success) {
        state = AsyncValue.data(state.value!.where((e) => e.id != id).toList());
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
