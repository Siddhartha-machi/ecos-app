import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/providers/provider_root.dart';
import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/common/enums/extensions_enums.dart';
import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/common/atoms/generic_app_listview.dart';
import 'package:ecos_main/common/base_widgets/data_service_widget.dart';
import 'package:ecos_main/common/background/custom_color_gradient.dart';

class ExtensionListingScreen extends DataConsumerWidget<Extension> {
  ExtensionListingScreen({super.key})
      : super(provider: extensionNotifierProvider);

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

  void _showExtensionDetail(BuildContext ctx, Extension ext) {
    final path = Paths.extension.extensionInfo.absolutePath;
    GoRouter.of(ctx).push(path.replaceAll(':id', ext.id));
  }

  Widget _buildExtensionItem(Extension extension, BuildContext ctx) {
    return SizedBox(
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: () => _showExtensionDetail(ctx, extension),
        child: CustomColorGradient(
          gradientColor: Color(extension.color),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: ValueKey(extension.id),
                  child: Icon(
                    IconData(extension.iconCode, fontFamily: 'MaterialIcons'),
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  extension.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        customWidget: (ext) => _buildExtensionItem(ext, ctx),
      ),
    );
  }

  @override
  Widget renderUI(BuildContext context, dynamic data, WidgetRef ref) {
    return Padding(
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
    );
  }
}
