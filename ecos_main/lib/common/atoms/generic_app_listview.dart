import 'package:flutter/material.dart';

class GenericAppListView<D, W extends Widget> extends StatelessWidget {
  const GenericAppListView({
    super.key,
    required this.data,
    required this.customWidget,
    this.title,
    this.direction = Axis.vertical,
    this.gap = 0,
  });

  final List<D> data;
  final W Function(D) customWidget;
  final String? title;
  final double gap;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        Flexible(
          child: ListView.separated(
            scrollDirection: direction,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (_, __) => direction == Axis.vertical
                ? SizedBox(height: gap)
                : SizedBox(width: gap),
            itemBuilder: (ctx, index) => customWidget(data[index]),
          ),
        ),
      ],
    );
  }
}
