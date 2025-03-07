import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/repositories/extension_detail_data_service.dart';

class ExtensionDetailNotifier
    extends StateNotifier<AsyncValue<List<ExtensionDetail>>> {
  final ExtensionDetailDataService extensionDetailService;

  ExtensionDetailNotifier(this.extensionDetailService)
      : super(const AsyncValue.loading()) {
    fetchExtensionDetails();
  }

  Future<void> fetchExtensionDetails() async {
    state = const AsyncValue.loading();
    try {
      final extensionDetail = await extensionDetailService.fetchAll();
      state = AsyncValue.data(extensionDetail);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createExtensionDetail(ExtensionDetail extensionDetail) async {
    try {
      final newExtensionDetail =
          await extensionDetailService.createItem(extensionDetail);
      state = AsyncValue.data([...state.value ?? [], newExtensionDetail]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateExtensionDetail(
      String id, ExtensionDetail extensionDetail) async {
    try {
      final updatedExtensionDetail =
          await extensionDetailService.updateItem(id, extensionDetail);
      state = AsyncValue.data(
        state.value!
            .map((e) => e.id == id ? updatedExtensionDetail : e)
            .toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteExtensionDetail(String id) async {
    try {
      final success = await extensionDetailService.deleteItem(id);
      if (success) {
        state = AsyncValue.data(state.value!.where((e) => e.id != id).toList());
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
