import 'package:flutter/material.dart';

//Кастомная тема для расширения под разные дизайны
class CustomColorScheme extends ColorScheme {
  const CustomColorScheme({
    required Color primary,
    required Color primaryVariant,
    required Color secondary,
    required Color secondaryVariant,
    required Color surface,
    required Color background,
    required Color error,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
    required Color onBackground,
    required Color onError,
    required Brightness brightness,
  }) : super(
          primary: primary,
          primaryVariant: primaryVariant,
          secondary: secondary,
          secondaryVariant: secondaryVariant,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightness,
        );
}
