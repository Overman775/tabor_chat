import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await PrecacheImage.precache();

  // Подключение зависимостей
  configInjector(env: Environment.prod);

  runApp(
    BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: AppLocalization(
        child: ScreenUtilInit(
          designSize: const Size(320, 663),
          builder: () {
            return const AppMain();
          },
        ),
      ),
    ),
  );
}

class AppMain extends StatelessWidget {
  const AppMain();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeBloc>().state.theme.themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MadNavigator(
        observers: <NavigatorObserver>[
          HeroController(),
        ],
      ),
    );
  }
}
