import 'dart:math';

const _suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
const _kilo = 1204;

extension IntBytesExtension on int {
  String formatBytes([int decimals = 2]) {
    if (this <= 0) {
      return "0 B";
    }

    final i = (log(this) / log(_kilo)).floor();
    final size = this / pow(_kilo, i);
    return '${size.toStringAsFixed(decimals)} ${_suffixes[i]}';
  }
}
