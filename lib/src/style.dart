import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class Insets {
  const Insets._();

  static const p2 = 2.0;
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p18 = 18.0;
  static const p24 = 24.0;
}

class IconSizes {
  const IconSizes._();

  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p40 = 40.0;
  static const p48 = 48.0;
}

class Gaps {
  const Gaps._();

  static const p2 = Gap(Insets.p2);
  static const p4 = Gap(Insets.p4);
  static const p8 = Gap(Insets.p8);
  static const p12 = Gap(Insets.p12);
  static const p16 = Gap(Insets.p16);
  static const p18 = Gap(Insets.p18);
  static const p24 = Gap(Insets.p24);
}

class DialogConstraints {
  const DialogConstraints._();

  static const dialog = BoxConstraints(
    maxWidth: 800,
    minWidth: 600,
    maxHeight: 600,
  );

  static const picker = BoxConstraints(
    maxWidth: 480,
    minWidth: 480,
    maxHeight: 320,
  );
}
