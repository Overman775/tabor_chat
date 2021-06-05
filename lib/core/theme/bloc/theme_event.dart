part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => <Object>[];
}

class ThemeChangeEvent extends ThemeEvent {
  const ThemeChangeEvent({required this.themeType});

  final ThemeType themeType;
}
