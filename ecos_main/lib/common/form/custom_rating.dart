import 'package:ecos_main/common/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/form/models.dart';
import 'package:flutter_rating/flutter_rating.dart';

class CustomRating extends StatelessWidget {
  const CustomRating(
    this.config, {
    super.key,
  });

  final GenericFormField config;

  Widget _title(FormFieldState<double> state) {
    return Expanded(
      child: Text(
        config.label!,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color:
              state.hasError ? Theme.of(state.context).colorScheme.error : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderField<double>(
        name: config.name,
        builder: (state) => config.type == GenericFieldType.rating
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (Global.isSafe(config.label)) _title(state),
                  StarRating(
                    allowHalfRating: true,
                    size: config.size,
                    rating: state.value ?? 0.0,
                    onRatingChanged: state.didChange,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )
            : EmojiFeedback(
                showLabel: true,
                rating: state.value?.toInt() ?? 5,
                elementSize: config.size,
                onChanged: (val) => state.didChange(val?.toDouble()),
              ),
      ),
    );
  }
}
