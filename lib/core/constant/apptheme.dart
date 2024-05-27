import 'package:flutter/material.dart';
import 'package:smart_home/core/constant/colors.dart';

class AppTheme {
  static ThemeData currentTheme = themeEnglish;
  static ThemeData themeEnglish = ThemeData(
    dividerTheme: const DividerThemeData(color: AppColors.secondColor),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.primaryColor),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.whiteColor,
      titleTextStyle: const TextStyle(color: AppColors.whiteColor),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.secondColor),
      ),
      leadingAndTrailingTextStyle: const TextStyle(color: AppColors.whiteColor),
    ),
    navigationDrawerTheme: const NavigationDrawerThemeData(
        backgroundColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.backGroundColor,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondColor),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
          fontFamily: "PlayfairDisplay"),
      displayMedium: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
          fontFamily: "PlayfairDisplay"),
      displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Colors.grey[900],
          fontFamily: "Roboto"),
      bodyLarge: const TextStyle(
        height: 2,
        fontFamily: "Cairo",
        fontSize: 14,
      ),
      bodyMedium: const TextStyle(
        height: 2,
        fontSize: 12,
        fontFamily: "Cairo",
      ),
    ),
  );
}
