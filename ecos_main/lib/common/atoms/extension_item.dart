import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/common/background/custom_color_gradient.dart';

class ExtensionItem extends StatelessWidget {
  const ExtensionItem(this.extension, {super.key});

  final Extension extension;

  void _showExtensionDetail(BuildContext ctx, Extension ext) {
    final path = Paths.main.extensionDetail.absolutePath;
    GoRouter.of(ctx).push(path.replaceAll(':id', ext.id));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: () => _showExtensionDetail(context, extension),
        child: CustomColorGradient(
          gradientColor: Color(extension.color),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconData(extension.iconCode, fontFamily: 'MaterialIcons'),
                  size: 30,
                  color: Colors.white,
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
}
