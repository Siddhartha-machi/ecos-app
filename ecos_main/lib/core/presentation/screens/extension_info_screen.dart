import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/core/utils/utils.dart';
import 'package:ecos_main/core/state/provider_root.dart';
import 'package:ecos_main/shared/presentation/widgets/form/form_manager.dart';
import 'package:ecos_main/shared/models/form_models.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/custom_divider.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/extension_item.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/contained_button.dart';
import 'package:ecos_main/core/data/models/extension_models.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/custom_bottom_sheet.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/generic_app_listview.dart';
import 'package:ecos_main/shared/presentation/widgets/background/custom_color_gradient.dart';
import 'package:ecos_main/shared/presentation/widgets/atoms/async_state_handler_widget.dart';

class ExtensionDetailScreen extends ConsumerWidget {
  ExtensionDetailScreen(this._routeState, {super.key});

  final GoRouterState _routeState;

  // Configuration for the review form
  final List<GenericFormField> _reviewFormConfig = [
    GenericFormField(
      name: 'rating',
      type: GenericFieldType.feedback,
      size: 40,
      label: 'Rate',
    ),
    GenericFormField(
      name: 'title',
      maxLength: 50,
      minLength: 5,
      type: GenericFieldType.text,
      label: 'Title',
      isRequired: true,
      hintText: 'Your opinion in one word.',
    ),
    GenericFormField(
      name: 'description',
      maxLength: 250,
      minLength: 5,
      rows: 3,
      type: GenericFieldType.text,
      label: 'Review',
      isRequired: true,
      hintText:
          'Tell us which feature you liked the most and what can be improved',
    ),
  ];

  // Builds the header section of the extension detail screen
  Widget _buildHeader(BuildContext ctx, ExtensionDetail data) {
    return Row(
      children: [
        CustomColorGradient(
          margin: const EdgeInsets.only(right: 12.0),
          gradientColor: Theme.of(ctx).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              size: 50,
              IconData(
                data.iconCode,
                fontFamily: 'MaterialIcons',
              ),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  data.title,
                  style: Theme.of(ctx).textTheme.titleLarge,
                ),
                const SizedBox(height: 6.0),
                Text(
                  data.caption,
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
                const SizedBox(height: 6.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Builds a metadata item
  Widget _metaItem(String title, String value, Widget child) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
          child,
        ],
      ),
    );
  }

  // Builds the metadata section of the extension detail screen
  Widget _buildMetaData(BuildContext ctx, ExtensionDetail data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metaItem(
            'Ratings',
            data.ratings.toString(),
            StarRating(
              rating: 5,
              size: 15,
              color: Theme.of(ctx).primaryColor,
            ),
          ),
          _metaItem('Age', data.meta.ageRequired, const Text('Years old')),
          _metaItem(
            'Chart',
            'No.${data.meta.rankInTheCategory}',
            Text(data.category.name),
          ),
        ],
      ),
    );
  }

  // Builds the description section of the extension detail screen
  Widget _buildDescription(BuildContext ctx, ExtensionDetail data) {
    return Text(
      data.description,
      style: Theme.of(ctx).textTheme.bodyMedium,
    );
  }

  // Builds the images list section of the extension detail screen
  Widget _buildImagesList(BuildContext ctx, List<String> images) {
    if (images.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 50,
              color: Theme.of(ctx).colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'No images found',
              style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(ctx).colorScheme.onSurface.withOpacity(0.5),
                  ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: GenericAppListView(
        direction: Axis.horizontal,
        gap: 12.0,
        data: images,
        customWidget: (img) => ClipRRect(
          child: Image.network(img, fit: BoxFit.contain),
        ),
      ),
    );
  }

  // Builds the comments header section
  Widget _buildCommentsHeader(BuildContext context, ExtensionDetail data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Ratings and Reviews'),
        TextButton(
          child: const Text('Write a review'),
          onPressed: () => _showReviewDialog(context, data.title),
        ),
      ],
    );
  }

  // Builds the comments summary section
  Widget _buildCommentsSummary(BuildContext context, ExtensionDetail data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              data.ratings.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Text('out of 5'),
          ],
        ),
        Column(
          children: [
            Text('${data.totalCommentsCount} reviews'),
            const SizedBox(height: 2),
            TextButton(
              child: const Text('View all'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  // Builds a single comment item
  Widget _buildCommentItem(
      BuildContext context, double width, Comment comment) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.secondaryContainer,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  comment.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(Global.formattedDate(comment.createdAt)),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StarRating(
                rating: comment.rating,
                allowHalfRating: true,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              Text(
                  '${comment.createdBy.firstName} ${comment.createdBy.lastName}')
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            comment.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          )
        ],
      ),
    );
  }

  // Builds the comments list view section
  Widget _buildCommentsListView(
      BuildContext context, double width, List<Comment> comments) {
    return SizedBox(
      height: 140,
      child: Column(
        children: [
          Expanded(
            child: GenericAppListView(
              gap: 12.0,
              direction: Axis.horizontal,
              data: comments,
              customWidget: (comment) =>
                  _buildCommentItem(context, width, comment),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the similar extensions section
  Widget _buildSimilarExtensions(BuildContext ctx, List<Extension> eList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Similar extensions'),
            TextButton(
              child: const Text('View all'),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 80,
          child: GenericAppListView(
            gap: 12.0,
            direction: Axis.horizontal,
            data: eList,
            customWidget: (ext) => ExtensionItem(ext),
          ),
        ),
      ],
    );
  }

  // Shows the review dialog
  _showReviewDialog(BuildContext ctx, String todoTitle) {
    final formKey = GlobalKey<FormBuilderState>();

    // Handler for form submission
    submitHandler() {
      if (formKey.currentState?.saveAndValidate() == true) {
        print(formKey.currentState!.value);
      }
    }

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return CustomBottomSheet(
          title: 'Rate the $todoTitle extension',
          children: [
            const SizedBox(height: 12.0),
            FormManager(
              formKey: formKey,
              fields: _reviewFormConfig,
            ),
            ContainedButton(onPressed: submitHandler, label: 'Submit'),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('I\'ll do it later'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = _routeState.pathParameters['id'];
    final state = ref.watch(extensionDetailNotifierProvider(id ?? ''));
    const padding = 12.0;
    final width = MediaQuery.sizeOf(context).width - (padding * 2);
    return AsyncStateHandlerWidget(
      state: state,
      renderUI: (ExtensionDetail? data) {
        if (Global.isSafe(data)) {
          return Scaffold(
            appBar: AppBar(title: Text('${data!.title} Extension')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, data),
                  const CustomDivider(padding: 8.0),
                  _buildMetaData(context, data),
                  const CustomDivider(padding: 8.0),
                  _buildDescription(context, data),
                  const SizedBox(height: 16.0),
                  // Images
                  _buildImagesList(context, data.images),
                  const CustomDivider(padding: 8.0),
                  // Comments
                  _buildCommentsHeader(context, data),
                  _buildCommentsSummary(context, data),
                  const SizedBox(height: 10.0),
                  _buildCommentsListView(context, width, data.comments),
                  const CustomDivider(padding: 8.0),
                  // Similar Extensions
                  _buildSimilarExtensions(context, data.similarExtensions),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        // TODO: Add a custom error widget
        return const Center(child: Text('No data found'));
      },
    );
  }
}
