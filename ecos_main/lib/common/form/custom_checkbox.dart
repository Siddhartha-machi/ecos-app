import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/validators.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(this.config, {super.key});

  final GenericFormField config;

  Widget _title(FormFieldState<bool> state) {
    return Text(
      config.label ?? '',
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color:
            state.hasError ? Theme.of(state.context).colorScheme.error : null,
      ),
    );
  }

  Widget? _subTitle(FormFieldState<bool> state) {
    return Global.isSafe(config.hintText)
        ? Text(
            config.hintText!,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: state.hasError
                  ? Theme.of(state.context).colorScheme.error
                  : Theme.of(state.context).dividerColor,
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: FormBuilderField<bool>(
        name: config.name,
        autovalidateMode: AutovalidateMode.onUnfocus,
        validator: ValidatorFactory.checkFieldValidator(config),
        builder: (state) => SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.all(0.0),
          title: _title(state),
          subtitle: _subTitle(state),
          value: state.value ?? false,
          onChanged: state.didChange,
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
