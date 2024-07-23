import 'package:flutter/widgets.dart';
import 'package:real_downloader/src/utils/string.dart';

class FormFieldValidators {
  const FormFieldValidators._();

  static FormFieldValidator<String> isNotBlankValidator({
    required String errorText,
  }) {
    return (value) => value?.isNotBlank ?? true ? null : errorText;
  }
}
