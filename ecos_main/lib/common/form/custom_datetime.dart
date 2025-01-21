import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/utils.dart';

class CustomDatetime extends StatelessWidget {
  const CustomDatetime(this.config, {super.key});

  final GenericFormField config;

  List<Widget> _icon(FormFieldState state) {
    return [
      Icon(
        IconData(
          config.prefixIcon!,
          fontFamily: 'MaterialIcons',
        ),
        size: 18,
        color:
            state.hasError ? Theme.of(state.context).colorScheme.error : null,
      ),
      const SizedBox(width: 6.0),
    ];
  }

  List<Widget> _errIcon(FormFieldState state) {
    return [
      const SizedBox(width: 8.0),
      Tooltip(
        message: state.errorText,
        child: Icon(
          Icons.error_rounded,
          size: 18,
          color: Theme.of(state.context).colorScheme.error,
        ),
      )
    ];
  }

  InputDecoration _useDecoration(BuildContext ctx, FormFieldState state) {
    return InputDecoration(
      suffixIcon: const Icon(Icons.arrow_forward_ios_outlined, size: 16),
      suffixIconConstraints: const BoxConstraints(maxHeight: 16),
      contentPadding: const EdgeInsets.all(0.0),
      hintText: config.hintText,
      labelStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: state.hasError ? Theme.of(ctx).colorScheme.error : null,
      ),
      hintStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
        color: Theme.of(ctx).dividerColor,
      ),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    );
  }

  Map<String, dynamic> get _modeSettings {
    final settings = {'type': InputType.date, 'formatter': DateFormat.yMMMEd()};

    if (config.type == GenericFieldType.time) {
      settings['type'] = InputType.time;
      settings['formatter'] = DateFormat.jm();
    } else if (config.type == GenericFieldType.dateTime) {
      settings['type'] = InputType.both;
      settings['formatter'] = DateFormat.yMMMEd().add_jm();
    }
    return settings;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
        name: config.name,
        validator: ValidatorFactory.dateTimeValidator(config),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          final decoration = _useDecoration(context, state);
          return Row(
            children: [
              if (Global.isSafe(config.prefixIcon)) ..._icon(state),
              if (Global.isSafe(config.label))
                Text(config.label!, style: decoration.labelStyle),
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: config.name,
                  initialValue: state.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2040),
                  inputType: _modeSettings['type'],
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
                  onChanged: state.didChange,
                  format: _modeSettings['formatter'],
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: decoration,
                ),
              ),
              if (!state.isValid && state.hasError) ..._errIcon(state),
            ],
          );
        });
  }
}
