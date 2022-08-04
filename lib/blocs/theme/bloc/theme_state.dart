part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;
  const ThemeState({this.isDarkTheme = false});

  @override
  List<Object> get props => [isDarkTheme];
}
