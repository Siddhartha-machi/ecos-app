enum GenericFieldType {
  text,
  integer,
  double,
  email,
  password,
  checkbox,
  radio,
  dropdown,
  date,
  time,
  dateTime,
  file,
  rating,
  feedback,
}

class GenericFormField {
  final String name;
  final GenericFieldType type;

  // Optional attributes
  final String? label;
  final dynamic defaultValue;
  final String? hintText;
  final String? helperText;
  final List<GenericFieldOption>? options; // For dropdown, radio, etc.
  final Map<String, dynamic>? dependencies;
  final double? size;
  final dynamic showIfValue;
  final bool halfWidth;
  final double? gap;
  final int? prefixIcon;
  final int? suffixIcon;
  final String? group;

  // Validation attributes
  final int rows;
  final bool? isRequired;
  final int? minLength;
  final int? maxLength;
  final int? min;
  final int? max;

  GenericFormField({
    required this.name,
    required this.type,
    this.label,
    this.isRequired = false,
    this.hintText,
    this.defaultValue,
    this.options,
    this.minLength,
    this.maxLength,
    this.rows = 1,
    this.helperText,
    this.max,
    this.min,
    this.size,
    this.prefixIcon,
    this.suffixIcon,
    // Custom attributes
    this.showIfValue,
    this.gap,
    this.halfWidth = false,
    this.dependencies,
    this.group,
  });
}

class GenericFieldOption {
  const GenericFieldOption({
    required this.value,
    required this.optionLabel,
    this.helperText,
    this.iconConfig,
  });

  final String value;
  final String optionLabel;
  final String? helperText;
  final int? iconConfig;
}
