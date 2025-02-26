import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/common/form/base_form_field.dart';

typedef _DropdownType = List<DropdownMenuItem<GenericFieldOption>>;

class CustomDropdown extends BaseFormField {
  const CustomDropdown({required super.config, super.key});

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

  GenericFieldOption? _selectedValue(FormFieldState<GenericFieldOption> state) {
    return state.value;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: config.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidatorFactory.dropdownFieldValidator(config),
      builder: (FormFieldState<GenericFieldOption> state) {
        return fieldWrapper(
          state: state,
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 8.0),
            title: Global.isSafe(config.label) ? buildLabel(state) : null,
            subtitle: Global.isSafe(config.hintText) ? buildCaption : null,
            trailing: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<GenericFieldOption>(
                  isDense: true,
                  hint: const Text('Select an option'),
                  value: _selectedValue(state),
                  items: _optionsList(state),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  onChanged: state.didChange,
                  padding: const EdgeInsets.fromLTRB(6, 3, 0, 3),
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
          ),
        );
      },
    );
  }
}
