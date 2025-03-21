import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:shared/utils/global.dart';
import 'package:shared/utils/validators.dart';
import 'package:shared/presentation/widgets/form/base_form_field.dart';


class CustomCheckbox extends BaseFormField<bool> {
  const CustomCheckbox({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
      name: config.name,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: ValidatorFactory.checkFieldValidator(config),
      builder: (state) => fieldWrapper(
        state: state,
        child: SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          title: Global.isSafe(config.label) ? buildLabel(state) : null,
          subtitle: Global.isSafe(config.hintText) ? buildCaption : null,
          value: state.value ?? false,
          onChanged: state.didChange,
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
