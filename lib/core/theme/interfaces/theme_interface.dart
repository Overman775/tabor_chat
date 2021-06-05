import 'package:flutter/material.dart';

import '../../core.dart';

abstract class AppTheme {
  late final TextTheme textTheme;
  late final CustomColorScheme colorScheme;

  ThemeData get themeData;
}
