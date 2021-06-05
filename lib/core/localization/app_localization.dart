import 'package:flutter/material.dart';

import '../core.dart';

class AppLocalization extends StatelessWidget {
  const AppLocalization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const <Locale>[Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      useOnlyLangCode: true,
      child: child,
    );
  }
}
