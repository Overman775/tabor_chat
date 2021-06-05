import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../core.dart';

/// Theme
extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  CustomColorScheme get colors => watch<ThemeBloc>().state.theme.colorScheme;
  TextTheme get themeText => Theme.of(this).textTheme;

  void changeTheme(ThemeType theme) => read<ThemeBloc>().add(ThemeChangeEvent(themeType: theme));
}
