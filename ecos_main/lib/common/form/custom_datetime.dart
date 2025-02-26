import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/validators.dart';
import 'package:ecos_main/common/form/base_form_field.dart';

class CustomDatetime extends BaseFormField<DateTime> {
  const CustomDatetime({required super.config, super.key});

  // Get mode settings based on config type
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
  InputDecoration buildDecoration(FormFieldState<DateTime> state) {
    final defaultDecoration = super.buildDecoration(state);

    return InputDecoration(
      hintText: defaultDecoration.hintText,
      suffixIcon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      suffixIconColor: null,
      border: defaultDecoration.border,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: config.name,
      validator: ValidatorFactory.dateTimeValidator(config),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return fieldWrapper(
          state: state,
          child: Row(
            children: [
              ...buildPrefix(state),
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: '${config.name}-date-picker',
                  initialValue: state.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2040),
                  inputType: _modeSettings['type'],
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
                  onChanged: state.didChange,
                  format: _modeSettings['formatter'],
                  textAlign: TextAlign.end,
                  style: buildTextStyle,
                  decoration: buildDecoration(state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
