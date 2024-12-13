import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/form/models.dart';
import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/utils.dart';

typedef _DropdownType = List<DropdownMenuItem<GenericFieldOption>>;

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(this.config, {super.key});

  final GenericFormField config;

  _DropdownType _optionsList(FormFieldState<GenericFieldOption> state) {
    _DropdownType options = [];

    if (Global.isSafe(config.options)) {
      for (final option in config.options!) {
        options.add(
          DropdownMenuItem<GenericFieldOption>(
            value: option,
            child: Text(
              option.optionLabel,
              style: state.value == option
                  ? TextStyle(color: Theme.of(state.context).primaryColor)
                  : null,
            ),
          ),
        );
      }
    }
    return options;
  }

  Widget? _title(String? label, BuildContext ctx, bool hasError) {
    return Global.isSafe(label)
        ? Text(
            label!,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: hasError ? Theme.of(ctx).colorScheme.error : null,
            ),
          )
        : null;
  }

  Widget? _subTitle(String? text, BuildContext ctx, bool hasError) {
    return Global.isSafe(text)
        ? Text(
            text!,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: hasError
                  ? Theme.of(ctx).colorScheme.error
                  : Theme.of(ctx).dividerColor,
            ),
          )
        : null;
  }

  GenericFieldOption _selectedValue(state) {
    return state.value ?? config.options?.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: config.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidatorFactory.dropdownFieldValidator(config),
      builder: (FormFieldState<GenericFieldOption> state) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: _title(config.label!, context, state.hasError),
          subtitle: _subTitle(config.hintText, context, state.hasError),
          trailing: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<GenericFieldOption>(
                isDense: true,
                value: _selectedValue(state),
                items: _optionsList(state),
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                onChanged: state.didChange,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                icon: const Icon(Icons.unfold_more_rounded),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                iconEnabledColor: Theme.of(context).colorScheme.onSurface,
                dropdownColor: Theme.of(context).colorScheme.surface,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ),
          ),
        );
      },
    );
  }
}
