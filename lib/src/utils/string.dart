extension StringExtension on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => trim().isNotEmpty;

  String? get blankToNull => isBlank ? null : this;
}
