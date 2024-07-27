import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  ThemeData build() {
    const colorTheme = AppColorTheme.light();

    final colorScheme = ColorScheme.fromSeed(
      seedColor: colorTheme.primary,
      surface: colorTheme.background,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: const [
        colorTheme,
      ],
    );

    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      scaffoldBackgroundColor: colorTheme.background,
      cardTheme: CardTheme(
        color: colorTheme.background,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorTheme.background,
      ),
    );
  }
}

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  const AppColorTheme({
    required this.primary,
    required this.background,
  });

  const AppColorTheme.light({
    this.primary = Colors.blueAccent,
    this.background = Colors.white,
  });

  final Color primary;
  final Color background;

  @override
  AppColorTheme copyWith({
    Color? primary,
    Color? background,
  }) {
    return AppColorTheme(
      primary: primary ?? this.primary,
      background: background ?? this.background,
    );
  }

  @override
  AppColorTheme lerp(AppColorTheme other, double t) {
    return AppColorTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}

extension ThemeDataExtension on ThemeData {
  AppColorTheme get colorTheme => extension<AppColorTheme>()!;
}
