import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/repositories/extension_detail_data_service.dart';

class ExtensionDetailNotifier
    extends StateNotifier<AsyncValue<ExtensionDetail?>> {
  final ExtensionDetailDataService extensionDetailService;
  final String _id;

  ExtensionDetailNotifier(this.extensionDetailService, this._id)
      : super(const AsyncValue.loading()) {
    fetchExtensionDetail();
  }

  Future<void> fetchExtensionDetail() async {
    state = const AsyncValue.loading();
    try {
      final extensionDetail = await extensionDetailService.fetchById(_id);
      state = AsyncValue.data(extensionDetail);
    } catch (e, stackTrace) {
      debugPrint('Application error : ${stackTrace.toString()}');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createExtensionDetail(ExtensionDetail extensionDetail) async {
    try {
      final newExtensionDetail =
          await extensionDetailService.createItem(extensionDetail);
      state = AsyncValue.data(newExtensionDetail);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateExtensionDetail(
      String id, ExtensionDetail updatedDetail) async {
    try {
      final updatedExtensionDetail =
          await extensionDetailService.updateItem(id, updatedDetail);
      state = AsyncValue.data(updatedExtensionDetail);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteExtensionDetail(String id) async {
    try {
      final success = await extensionDetailService.deleteItem(id);
      if (success) {
        state = const AsyncValue.data(null);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
