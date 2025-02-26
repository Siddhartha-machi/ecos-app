import 'package:flutter/material.dart';

import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/utils.dart';

abstract class BaseFormField<T> extends StatelessWidget {
  const BaseFormField({required this.config, super.key});

  final GenericFormField config;
  static const double space = 8.0;

  // Private methods
  Widget _buildIcon(int iconData, FormFieldState<T> state) {
    return Icon(
      IconData(iconData, fontFamily: 'MaterialIcons'),
      size: 18,
      color: state.hasError
          ? Theme.of(state.context).colorScheme.error
          : Theme.of(state.context).primaryColor,
    );
  }

  List<Widget> _errorText(FormFieldState<T> state) {
    if (state.hasError && Global.isSafe(state.errorText)) {
      return [
        const SizedBox(height: 4),
        Text(
          state.errorText!,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Theme.of(state.context).colorScheme.error,
          ),
        ),
      ];
    }
    return [];
  }

  // Protected methods for the child classes
  @protected
  Widget buildLabel(FormFieldState<T> state) {
    return Text(
      config.label!,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w800,
        color: state.hasError
            ? Theme.of(state.context).colorScheme.error
            : Theme.of(state.context).textTheme.labelLarge?.color,
      ),
    );
  }

  @protected
  Widget get buildCaption {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        config.hintText!,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @protected
  TextStyle get buildTextStyle {
    return const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    );
  }

  @protected
  InputDecoration buildDecoration(FormFieldState<T> state) {
    final theme = Theme.of(state.context);
    final hasError = state.hasError;
    final isValid = state.hasInteractedByUser &&
        state.isValid &&
        !Global.isEmpty(state.value);

    return InputDecoration(
      hintText: config.hintText,
      suffixIcon: hasError
          ? const Icon(Icons.error, size: 18)
          : isValid
              ? const Icon(Icons.check_circle, size: 18)
              : null,
      suffixIconColor: hasError ? theme.colorScheme.error : Colors.green,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    );
  }

  @protected
  List<Widget> buildPrefix(FormFieldState<T> state) {
    List<Widget> prefix = [];

    // Add the prefix icon first before adding label and suffix icon
    if (Global.isSafe(config.prefixIcon)) {
      prefix.add(const SizedBox(width: space));
      prefix.add(_buildIcon(config.prefixIcon!, state));
    }

    if (Global.isSafe(config.label)) {
      prefix.add(const SizedBox(width: space));
      prefix.add(buildLabel(state));
    }

    if (Global.isSafe(config.suffixIcon)) {
      prefix.add(const SizedBox(width: space));
      prefix.add(_buildIcon(config.suffixIcon!, state));
    }

    if (prefix.isEmpty) {
      prefix.add(const SizedBox(width: space));
    }

    return prefix;
  }

  @protected
  Widget buildErrorIcon(FormFieldState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        Icons.warning_rounded,
        size: 18,
        color: Theme.of(state.context).colorScheme.error,
      ),
    );
  }

  @protected
  Widget fieldWrapper({
    required FormFieldState<T> state,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(state.context).colorScheme.onPrimary,
          ),
          child: child,
        ),
        ..._errorText(state),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    throw Exception("Must override the build method.");
  }
}
