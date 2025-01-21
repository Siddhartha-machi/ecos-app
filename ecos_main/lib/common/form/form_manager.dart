import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ecos_main/common/utils.dart';
import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/form/custom_textfield.dart';
import 'package:ecos_main/common/form/custom_rating.dart';
import 'package:ecos_main/common/form/custom_checkbox.dart';
import 'package:ecos_main/common/form/custom_dropdown.dart';
import 'package:ecos_main/common/form/custom_radio.dart';
import 'package:ecos_main/common/form/custom_datetime.dart';

// Main Dynamic Form Builder Widget
class FormManager extends StatelessWidget {
  final List<GenericFormField> fields;
  final GlobalKey<FormBuilderState> formKey;

  final bool isEditMode;
  final Map<String, dynamic>? initialData;
  final double? defaultGap;
  final EdgeInsetsGeometry? padding;
  final bool? useGroupName;

  const FormManager({
    super.key,
    required this.fields,
    required this.formKey,
    this.isEditMode = false,
    this.initialData,
    this.padding,
    this.useGroupName,
    this.defaultGap = 10,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: _initialData,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildFields(context),
        ),
      ),
    );
  }

  // Utils
  Map<String, dynamic> get _initialData {
    Map<String, dynamic> data = {};
    for (final field in fields) {
      data[field.name] = initialData?[field.name] ?? field.defaultValue;
    }

    return data;
  }

  bool _shouldBeVisible(GenericFormField field) {
    if (field.dependencies == null) return true;

    for (var dependencyKey in field.dependencies!.keys) {
      if (formKey.currentState?.fields[dependencyKey]?.value !=
          field.dependencies![dependencyKey]) {
        return false;
      }
    }

    return true;
  }

  Map<String, List<GenericFormField>> _convertToGroups() {
    Map<String, List<GenericFormField>> groups = {};

    for (var field in fields) {
      final key = Global.isSafe(field.group) ? field.group! : 'default';
      if (!Global.isSafe(groups[key])) {
        groups[key] = [];
      }
      groups[key]!.add(field);
    }

    return groups;
  }

  Widget _separator(bool vertical) {
    Widget separator = const VerticalDivider(indent: 6, endIndent: 6);

    if (vertical) {
      separator = const Divider(height: 0, indent: 0, thickness: 1);
    }

    return separator;
  }

  // Field Widget Builders
  List<Widget> _buildFields(BuildContext context) {
    final groups = _convertToGroups();

    List<Widget> widgets = [];

    for (final key in groups.keys) {
      final List<Widget> widgetGroup = [];
      List<Widget> rowChildren = [];
      final List<GenericFormField> currentGroup = groups[key]!;

      for (int i = 0; i < currentGroup.length; i++) {
        final currentField = currentGroup[i];
        final gap = currentField.gap ?? defaultGap ?? 0;
        Widget fieldWidget = _buildFieldWidget(context, currentField);

        if (currentField.halfWidth) {
          rowChildren.add(Flexible(flex: 1, child: fieldWidget));

          if (rowChildren.length == 3 ||
              i == currentGroup.length - 1 ||
              !currentGroup[i + 1].halfWidth) {
            if (rowChildren.length == 1) {
              rowChildren.add(SizedBox(width: gap));
              rowChildren.add(const Spacer(flex: 1));
            }
            widgetGroup.add(
              IntrinsicHeight(child: Row(children: [...rowChildren])),
            );
            widgetGroup.add(_separator(true));
            rowChildren = []; // Reset row children
          } else {
            rowChildren.add(_separator(false));
          }
        } else {
          widgetGroup.add(fieldWidget);
          widgetGroup.add(_separator(true));
        }
      }
      widgetGroup.removeLast();
      if (useGroupName == true && key != 'default') {
        widgets.add(Text(
          key,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ));
        widgets.add(const SizedBox(height: 10.0));
      }

      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Theme.of(context).dividerColor.withAlpha(100),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetGroup,
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildFieldWidget(BuildContext context, GenericFormField field) {
    Widget formField;

    switch (field.type) {
      case GenericFieldType.text:
      case GenericFieldType.integer:
      case GenericFieldType.double:
      case GenericFieldType.email:
      case GenericFieldType.password:
        formField = CustomTextfield(field);
      case GenericFieldType.checkbox:
        formField = CustomCheckbox(field);
      case GenericFieldType.rating:
      case GenericFieldType.feedback:
        formField = CustomRating(field);
      case GenericFieldType.radio:
        formField = CustomRadiobox(field);
      case GenericFieldType.dropdown:
        formField = CustomDropdown(field);
      case GenericFieldType.date:
      case GenericFieldType.time:
      case GenericFieldType.dateTime:
        formField = CustomDatetime(field);
      case GenericFieldType.file:
      // TODO
      default:
        formField = const Text("Unsupported Field Type");
    }

    if (_shouldBeVisible(field)) {
      return formField;
    }
    return Visibility(
      visible: _shouldBeVisible(field),
      child: formField,
    );
  }
}
