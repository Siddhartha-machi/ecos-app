import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/common/form/validators.dart';

class CustomRadiobox extends StatelessWidget {
  const CustomRadiobox(this.config, {super.key});

  final GenericFormField config;

  bool _isMatch(GenericFieldOption? val1, GenericFieldOption val2) {
    return val1?.value == val2.value;
  }

  double _height(text) {
    return 18 + (Global.isSafe(text) ? 25 : 7);
  }

  Widget _header(
      FormFieldState<GenericFieldOption> state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Global.isSafe(config.label))
            Text(
              config.label!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color:
                    state.hasError ? Theme.of(context).colorScheme.error : null,
              ),
            ),
          if (state.hasError)
            Tooltip(
              message: state.errorText,
              child: Icon(
                Icons.warning,
                size: 18,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _label(GenericFieldOption option) {
    return Text(
      option.optionLabel,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget? _subLabel(GenericFieldOption option) {
    return (Global.isSafe(option.helperText))
        ? Text(
            option.helperText!,
            style: const TextStyle(fontSize: 10),
          )
        : null;
  }

  Widget _nativeCheckIcon(bool isMatch, BuildContext context) {
    return Icon(
      Platform.isIOS ? CupertinoIcons.check_mark : Icons.check,
      color: isMatch ? null : Theme.of(context).colorScheme.onPrimary,
      size: 18,
    );
  }

  ShapeBorder _activeBorder(bool isMatch, BuildContext context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: isMatch ? Theme.of(context).primaryColor : Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<GenericFieldOption>(
      autovalidateMode: AutovalidateMode.onUnfocus,
      name: config.name,
      validator: ValidatorFactory.radioFieldValidator(config),
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _header(state, context),
          if (Global.isSafe(config.options))
            ...config.options!.map<Widget>(
              (item) {
                final isMatch = _isMatch(state.value, item);
                return ListTile(
                  onTap: () => state.didChange(item),
                  dense: true,
                  minTileHeight: _height(item.helperText),
                  shape: _activeBorder(isMatch, context),
                  selected: isMatch,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                  title: _label(item),
                  subtitle: _subLabel(item),
                  trailing: _nativeCheckIcon(isMatch, context),
                );
              },
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
