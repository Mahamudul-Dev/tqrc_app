import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';


class AppThemeData {

  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: kLightBgColor,
    primarySwatch: kLightPrimarySwatchColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kWhite,
      foregroundColor: kBlackLight,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    // primaryColor: appColorPrimary,
    // primaryColorDark: appColorPrimary,
    // errorColor: Colors.red,
    // hoverColor: Colors.white54,
    // dividerColor: const Color(0xFFEAEAEA),
    // // fontFamily: GoogleFonts.openSans().fontFamily,
    // appBarTheme: const AppBarTheme(
    //   color: appLayout_background,
    //   iconTheme: IconThemeData(color: textLight),
    //   systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    // ),
    // // textTheme: GoogleFonts.montserratTextTheme(),
    // textSelectionTheme: const TextSelectionThemeData(cursorColor: textDark),
    // inputDecorationTheme: InputDecorationTheme(
    //     contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
    //     // hintStyle: primaryTextStyle(),
    //     filled: true,
    //     fillColor: bgLight,
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(40),
    //       borderSide: const BorderSide(color: bgLight, width: 0.0),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(40),
    //       borderSide: const BorderSide(color: bgLight, width: 0.0),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(40),
    //       borderSide: BorderSide.none,
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(40),
    //       borderSide: BorderSide.none,
    //     ),
    //     errorStyle: const TextStyle(
    //       fontSize: 16.0,
    //     )
    // ),
    // colorScheme: const ColorScheme.light(primary: appColorPrimary, primaryVariant: appColorPrimary),
    // cardTheme: const CardTheme(color: bgLight),
    // cardColor: bgLight,
    // iconTheme: const IconThemeData(color: textLight),
    // bottomSheetTheme: const BottomSheetThemeData(
    //     backgroundColor: bgLight
    // ),
    // // textTheme: TextTheme(
    // //   button: TextStyle(color: appColorPrimary),
    // //   headline6: TextStyle(color: textPrimaryColor),
    // //   subtitle2: TextStyle(color: textSecondaryColor),
    // // ),
    // visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );

  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
  }

  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (light icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
  }

  static void enableInitialThemeSetting(){
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// top and bottom, both status bar
  static void hideStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}