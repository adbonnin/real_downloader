import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class Insets {
  const Insets._();

  static const double p4 = 4;
  static const double p8 = 8;
  static const double p12 = 12;
  static const double p16 = 16;
  static const double p18 = 18;
  static const double p22 = 22;
}

class IconSizes {
  const IconSizes._();

  static const double p20 = 20;
  static const double p24 = 24;
  static const double p40 = 40;
  static const double p48 = 48;
}

class Gaps {
  const Gaps._();

  static const p4 = Gap(Insets.p4);
  static const p8 = Gap(Insets.p8);
  static const p12 = Gap(Insets.p12);
  static const p16 = Gap(Insets.p16);
  static const p18 = Gap(Insets.p18);
  static const p22 = Gap(Insets.p22);
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
