import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core.dart';

class AppThemeGreenLight implements AppTheme {
  @override
  TextTheme textTheme = ThemeData.light().textTheme.apply(
        fontFamily: 'Quicksand',
        bodyColor: const Color(0xFF676A6F),
        displayColor: const Color(0xFF3E3E3E),
      );

  @override
  CustomColorScheme colorScheme = const CustomColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF7CC547),
    primaryVariant: Color(0xFF6BA53D),
    primaryLight: Color(0xFFD8EEC8),
    secondary: Color(0xFFFF9F1E),
    secondaryVariant: Color(0xFFED861F),
    background: Colors.white,
    surface: Color(0xFFEEF2F7),
    onBackground: Colors.white,
    onSurface: Color(0xFF3E3E3E),
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: Color(0xFFED441F),
    gray: Color(0xFF676A6F),
    grayLight: Color(0xFFEEF2F7),
    grayDark: Color(0xFF3E3E3E),
  );

  @override
  ThemeData get themeData => ThemeData.from(
        colorScheme: colorScheme,
        textTheme: textTheme,
      ).copyWith(
        highlightColor: Colors.white.withOpacity(.25),
        splashColor: Colors.white.withOpacity(.25),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: false,
        ),
        bottomAppBarColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return colorScheme.grayLight;
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
          labelStyle: TextStyle(fontSize: 14.sp, color: colorScheme.gray),
          filled: true,
          fillColor: colorScheme.grayLight,
          helperMaxLines: 99,
          errorMaxLines: 99,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            gapPadding: 6,
            borderSide: BorderSide(color: colorScheme.gray.withOpacity(0.33)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            gapPadding: 6,
            borderSide: BorderSide(color: colorScheme.gray.withOpacity(0.33)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Ds.defaultMargin.w,
            vertical: Ds.defaultMargin.sp,
          ),
        ),
        dividerColor: colorScheme.grayDark,
      );
}
