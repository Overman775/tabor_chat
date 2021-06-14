import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';
import '../themes/theme_nane_nane.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: AppThemeNaneNane()));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangeEvent) {
      yield* _getTheme(event.themeType);
    }
  }

  /// Фильтруем темы и выводит нужную тему
  Stream<ThemeState> _getTheme(ThemeType themeType) async* {
    if (themeType == ThemeType.naneNane) {
      yield ThemeState(theme: AppThemeNaneNane());
    }
  }
}
