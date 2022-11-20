import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';

ThemeData theme() {
  return ThemeData(
      // scaffoldBackgroundColor: scaffoldBackground,
      primaryColor: thirdColor,
      // scrollbarTheme:
      //     ScrollbarThemeData(thumbColor: MaterialStateProperty.all(thirdColor)),
      colorScheme: const ColorScheme.light(secondary: firstColor),
      // backgroundColor: thirdColor,
      // applyElevationOverlayColor: true,
      fontFamily: 'NotoKufiArabic',
      textTheme: textTheme(),
      elevatedButtonTheme: elevatedButtonThemeData());
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
        fontSize: 20,
        fontFamily: 'NotoKufiArabic',
        color: secondColor,
        fontWeight: FontWeight.w500),
    headline2: TextStyle(
        color: secondColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        fontFamily: 'NotoKufiArabic'),
    headline3: TextStyle(
      fontSize: 15,
      fontFamily: 'NotoKufiArabic',
      fontWeight: FontWeight.w500,
      color: secondColor,
    ),
    headline4: TextStyle(
      color: secondColor,
      fontFamily: 'NotoKufiArabic',
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    headline5: TextStyle(
      color: secondColor,
      fontFamily: 'NotoKufiArabic',
      fontWeight: FontWeight.w500,
      fontSize: 11,
    ),
    headline6: TextStyle(
      color: secondColor,
      fontFamily: 'NotoKufiArabic',
      fontSize: 10.5,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontFamily: 'NotoKufiArabic',
      color: secondColor,
    ),
    bodyText2: TextStyle(
      color: secondColor,
      fontSize: 14,
      fontFamily: 'NotoKufiArabic',
    ),
  );
}
