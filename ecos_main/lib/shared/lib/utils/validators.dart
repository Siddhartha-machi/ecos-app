import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:shared/utils/global.dart';
import 'package:shared/models/form_models.dart';



typedef VType<T> = String? Function(T?);
typedef VLst<T> = List<VType<T>>;

class ValidatorFactory {
  // common validators
  static VType<T> _requiredValidator<T>(GenericFormField field, VLst<T> vLst,
      {String? customErr}) {
    if (Global.isEmpty(customErr)) {
      customErr = '${field.label ?? 'field'} is required.';
    }
    if (field.isRequired != true) {
      return (value) {
        if (!Global.isEmpty(value)) {
          final validator = FormBuilderValidators.compose<T>(vLst);
          return validator(value);
        }
        return null;
      };
    } else {
      return FormBuilderValidators.compose<T>(
          [FormBuilderValidators.required(errorText: customErr), ...vLst]);
    }
  }

  // String validator
  static VType<String> _stringValidator(GenericFormField field) {
    final VLst<String> validators = [];

    if (Global.isSafe(field.minLength)) {
      validators.add(FormBuilderValidators.minLength(field.minLength!));
    }

    return _requiredValidator<String>(field, validators);
  }

  // int validator
  static VType<String> _intValidator(GenericFormField field) {
    final VLst<String> validators = [];

    validators.add(FormBuilderValidators.integer());

    if (Global.isSafe(field.min)) {
      validators.add(FormBuilderValidators.min(field.min!));
    }
    if (Global.isSafe(field.max)) {
      validators.add(FormBuilderValidators.max(field.max!));
    }

    return _requiredValidator<String>(field, validators);
  }

  // Floating num validator
  static VType<String> _numValidator(GenericFormField field) {
    final VLst<String> validators = [];

    validators.add(FormBuilderValidators.numeric());

    if (Global.isSafe(field.min)) {
      validators.add(FormBuilderValidators.min(field.min!));
    }
    if (Global.isSafe(field.max)) {
      validators.add(FormBuilderValidators.max(field.max!));
    }

    return _requiredValidator<String>(field, validators);
  }

  // Validators
  static VType<String> genericStrValidator(GenericFormField field) {
    switch (field.type) {
      case GenericFieldType.password:
        return _stringValidator(field);
      case GenericFieldType.integer:
        return _intValidator(field);
      case GenericFieldType.double:
        return _numValidator(field);
      case GenericFieldType.email:
        return FormBuilderValidators.email();
      default:
        return _stringValidator(field);
    }
  }

  static VType<String> dateFieldValidator(GenericFormField field) {
    final validators = <String? Function(String?)>[];

    validators.add(FormBuilderValidators.date());

    return _requiredValidator<String>(field, validators);
  }

  static VType<GenericFieldOption> dropdownFieldValidator(
      GenericFormField field) {
    final validators = <String? Function(GenericFieldOption?)>[];

    return _requiredValidator<GenericFieldOption>(field, validators);
  }

  static VType<bool> checkFieldValidator(GenericFormField field) {
    final VLst<bool> validators = [];

    return _requiredValidator<bool>(
      field,
      validators,
      customErr: "You need to check this box.",
    );
  }

  static VType<GenericFieldOption> radioFieldValidator(GenericFormField field) {
    final validators = <String? Function(GenericFieldOption?)>[];

    return _requiredValidator<GenericFieldOption>(
      field,
      validators,
      customErr: "Select one of the options below.",
    );
  }

  static VType<DateTime> dateTimeValidator(GenericFormField field) {
    final validators = <String? Function(DateTime?)>[];

    return _requiredValidator<DateTime>(field, validators);
  }
}
