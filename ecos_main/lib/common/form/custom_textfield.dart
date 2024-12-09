import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/common/form/models.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(this.config, {super.key});

  final GenericFormField config;

  TextInputType get _useKeyboardType {
    TextInputType type;

    switch (config.type) {
      case GenericFieldType.integer:
      case GenericFieldType.double:
        type = TextInputType.number;
        break;
      case GenericFieldType.email:
        type = TextInputType.emailAddress;
        break;
      case GenericFieldType.password:
        type = TextInputType.visiblePassword;
        break;
      default:
        type = TextInputType.text;
    }

    return type;
  }

  List<Widget> _icon(FormFieldState state, bool left) {
    return [
      if (!left) const SizedBox(width: 6.0),
      Icon(
        IconData(
          left ? config.prefixIcon! : config.suffixIcon!,
          fontFamily: 'MaterialIcons',
        ),
        size: 18,
        color:
            state.hasError ? Theme.of(state.context).colorScheme.error : null,
      ),
      if (left) const SizedBox(width: 6.0),
    ];
  }

  InputDecoration _useDecoration(
      BuildContext context, FormFieldState<String> state) {
    return InputDecoration(
      // Configurations
      hintText: config.hintText,
      suffixIcon: state.hasError
          ? Tooltip(
              message: state.errorText,
              child: const Icon(Icons.warning, size: 18),
            )
          : state.hasInteractedByUser &&
                  state.isValid &&
                  !Global.isEmpty(state.value)
              ? const Icon(Icons.check_circle, size: 18)
              : null,

      // Styles
      // filled: true,
      suffixIconColor: state.hasError
          ? Theme.of(context).colorScheme.error
          : state.hasInteractedByUser && state.isValid
              ? Colors.green
              : null,
      labelStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: state.hasError ? Theme.of(context).colorScheme.error : null,
      ),
      hintStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
        color: Theme.of(context).dividerColor,
      ),

      border: const OutlineInputBorder(borderSide: BorderSide.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: config.name,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: ValidatorFactory.genericStrValidator(config),
      builder: (state) {
        final decoration = _useDecoration(context, state);
        return Row(
          children: [
            if (Global.isSafe(config.prefixIcon)) ..._icon(state, true),
            if (Global.isSafe(config.label))
              Text(config.label!, style: decoration.labelStyle),
            if (Global.isSafe(config.suffixIcon)) ..._icon(state, false),
            Expanded(
              child: TextFormField(
                minLines: config.rows,
                maxLines: config.rows,
                maxLength: config.maxLength,
                obscuringCharacter: '*',
                initialValue: state.value,
                textInputAction: TextInputAction.next,
                obscureText: config.type == GenericFieldType.password,
                keyboardType: _useKeyboardType,
                decoration: decoration,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: state.didChange,
              ),
            ),
          ],
        );
      },
    );
  }
}

// 