import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core.dart';

class AppThemeNaneNane implements AppTheme {
  @override
  TextTheme textTheme = ThemeData.dark().textTheme.apply(
        fontFamily: 'Cuprum',
        bodyColor: const Color(0xFFf9e4bb),
        displayColor: const Color(0xFFf9e4bb),
        decorationColor: const Color(0xFFf9e4bb),
      );

  @override
  CustomColorScheme colorScheme = const CustomColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF981c26),
    primaryVariant: Color(0xFF630000),
    secondary: Color(0xFFf5c565),
    secondaryVariant: Color(0xFFbf9536),
    background: Color(0xFF010101),
    surface: Color(0xFF010101),
    onBackground: Color(0xFFf9e4bb),
    onSurface: Color(0xFFf9e4bb),
    onError: Color(0xFF010101),
    onPrimary: Color(0xFF010101),
    onSecondary: Color(0xFF010101),
    error: Color(0xFFED441F),
  );
  @override
  ThemeData get themeData => ThemeData.from(
        colorScheme: colorScheme,
        textTheme: textTheme,
      ).copyWith(
        highlightColor: colorScheme.onSurface.withOpacity(.25),
        splashColor: colorScheme.onSurface.withOpacity(.25),
        appBarTheme: AppBarTheme(
            color: colorScheme.primaryVariant,
            brightness: Brightness.dark,
            centerTitle: false,
            titleTextStyle: TextStyle(color: colorScheme.secondary),
            toolbarTextStyle: TextStyle(color: colorScheme.secondary)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return colorScheme.onBackground;
              }
              return colorScheme.secondary;
            }),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14.sp)),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 16.sp, color: colorScheme.secondary),
          filled: true,
          fillColor: colorScheme.primaryVariant,
          helperMaxLines: 99,
          errorMaxLines: 99,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            gapPadding: 6,
            borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.33)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            gapPadding: 6,
            borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.33)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Ds.defaultMargin.w,
            vertical: Ds.defaultMargin.sp,
          ),
        ),
        dividerColor: colorScheme.onSurface,
      );
}
