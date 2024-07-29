import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_downloader/src/style.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.cardTheme,
  });

  const AppTheme.light({
    this.primaryColor = Colors.blueAccent,
    this.backgroundColor = Colors.white,
    this.cardTheme = const AppCardTheme.ligth(),
  });

  final Color primaryColor;
  final Color backgroundColor;
  final AppCardTheme cardTheme;

  ThemeData build() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      surface: backgroundColor,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: [
        this,
      ],
    );

    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardTheme(
        color: cardTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Insets.p8),
          side: BorderSide(
            color: cardTheme.borderColor,
            width: cardTheme.borderWidth,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  AppTheme copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    AppCardTheme? cardTheme,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardTheme: cardTheme ?? this.cardTheme,
    );
  }

  @override
  AppTheme lerp(AppTheme other, double t) {
    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      cardTheme: cardTheme.lerp(other.cardTheme, t),
    );
  }
}

class AppCardTheme extends ThemeExtension<AppCardTheme> {
  const AppCardTheme({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.backgroundColor,
  });

  const AppCardTheme.ligth({
    this.borderColor = Colors.black12,
    this.borderWidth = 1,
    this.borderRadius = Insets.p8,
    this.backgroundColor = Colors.white,
  });

  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color backgroundColor;

  @override
  AppCardTheme copyWith({
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? backgroundColor,
  }) {
    return AppCardTheme(
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  AppCardTheme lerp(AppCardTheme other, double t) {
    return AppCardTheme(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}

extension ThemeDataExtension on ThemeData {
  AppTheme get appTheme => extension<AppTheme>()!;
}
