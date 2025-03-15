import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/shared/lib/utils/global.dart';
import 'package:ecos_main/core/state/provider_root.dart';
import 'package:ecos_main/core/presentation/widgets/extension_item.dart';
import 'package:ecos_main/core/constants/enums/extensions_enums.dart';
import 'package:ecos_main/core/data/models/extension_models.dart';
import 'package:ecos_main/shared/lib/presentation/widgets/atoms/generic_app_listview.dart';
import 'package:ecos_main/shared/lib/presentation/widgets/atoms/async_state_handler_widget.dart';

class ExtensionListingScreen extends ConsumerWidget {
  const ExtensionListingScreen({super.key});

  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 16.0;
  static const double _itemHeight = 120.0;
  static const double _gapBetweenItems = 12.0;
  static const double _gapBetweenSections = 16.0;

  Map<ExtensionCategory, List<Extension>> _transformedData(
      List<Extension> extensions) {
    final Map<ExtensionCategory, List<Extension>> data = {};
    for (final extension in extensions) {
      data.putIfAbsent(extension.category, () => []).add(extension);
    }
    return data;
  }

  Widget _buildExtensionSection(
    data,
    ExtensionCategory category,
    BuildContext ctx,
  ) {
    return SizedBox(
      height: _itemHeight,
      child: GenericAppListView<Extension, Widget>(
        title: Global.capitalize(category.name),
        gap: _gapBetweenItems,
        direction: Axis.horizontal,
        data: _transformedData(data)[category] ?? [],
        customWidget: (ext) => ExtensionItem(ext),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(extensionNotifierProvider);

    return AsyncStateHandlerWidget(
      state: state,
      renderUI: (data) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        child: GenericAppListView<ExtensionCategory, Widget>(
          data: ExtensionCategory.values,
          gap: _gapBetweenSections,
          customWidget: (category) =>
              _buildExtensionSection(data, category, context),
        ),
      ),
    );
  }
}
