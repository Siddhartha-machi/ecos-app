import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/base_form_field.dart';

class CustomTextfield extends BaseFormField<String> {
  const CustomTextfield({required super.config, super.key});

  static const Map<GenericFieldType, TextInputType> _keyboardTypeMap = {
    GenericFieldType.integer: TextInputType.number,
    GenericFieldType.double: TextInputType.number,
    GenericFieldType.email: TextInputType.emailAddress,
    GenericFieldType.password: TextInputType.visiblePassword,
  };

  TextInputType get _useKeyboardType =>
      _keyboardTypeMap[config.type] ?? TextInputType.text;

  Widget _buildCustomWrapper({
    required Widget child,
    required FormFieldState<String> state,
  }) {
    // If the field is multiline use column-wise render
    // And add padding vertically
    if (config.rows > 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: BaseFormField.space),
        child: Column(children: [Row(children: buildPrefix(state)), child]),
      );
    }

    return Row(children: [...buildPrefix(state), Expanded(child: child)]);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: config.name,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: ValidatorFactory.genericStrValidator(config),
      builder: (state) {
        return fieldWrapper(
          state: state,
          child: _buildCustomWrapper(
            state: state,
            child: TextFormField(
              minLines: config.rows,
              maxLines: config.rows,
              maxLength: config.rows > 1 ? config.maxLength : null,
              obscuringCharacter: '*',
              initialValue: state.value,
              textInputAction: TextInputAction.next,
              obscureText: config.type == GenericFieldType.password,
              keyboardType: _useKeyboardType,
              decoration: buildDecoration(state),
              style: buildTextStyle,
              onChanged: state.didChange,
            ),
          ),
        );
      },
    );
  }
}
