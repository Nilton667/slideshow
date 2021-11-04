import 'package:flutter/material.dart';

mixin themeData {
  static Color themeColor = Color(0xffffffff);
  static Color whiteColor = Colors.white;
  static MaterialColor themePrimaryColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: whiteColor,
    primaryColor: themeColor,
    appBarTheme: AppBarTheme(
      actionsIconTheme: new IconThemeData(color: themeColor),
      iconTheme: new IconThemeData(color: themeColor),
      toolbarTextStyle: TextStyle(
        color: themeColor,
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
      color: whiteColor,
      elevation: 3.0,
      titleTextStyle: TextStyle(
        color: themeColor,
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
    ),
    toggleableActiveColor: themeColor,
    scaffoldBackgroundColor: whiteColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: themePrimaryColor,
    ).copyWith(
      secondary: themeColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xff121212),
    primaryColor: Color(0xff1f1f1f),
    appBarTheme: AppBarTheme(
      iconTheme: new IconThemeData(color: whiteColor),
      toolbarTextStyle: TextStyle(
        color: themeColor,
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
    ),
    cardColor: Color(0xff1f1f1f),
    scaffoldBackgroundColor: Color(0xff121212),
    toggleableActiveColor: themeColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: themePrimaryColor,
      brightness: Brightness.dark,
    ).copyWith(secondary: themeColor),
  );
}
