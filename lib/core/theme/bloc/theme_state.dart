part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  final AppTheme theme;

  @override
  List<Object?> get props => <Object>[theme];
}
