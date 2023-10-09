import 'package:flutter/material.dart';

Color kWhite = Colors.white;
Color kRed = Colors.red;
Color kRedLight = const Color(0xFFf36d58);
Color kRedMedium = const Color(0xFFff4f5a);
Color kDeepRed = const Color(0xFFF71B24);
Color kBlack = Colors.black;
Color kBlackLight = const Color(0xFF303030);
Color kBlackMedium = const Color(0xFF404040);
Color kBlue= const Color(0xFF3879E9);
Color kGrey = const Color(0xFF9EA1B6);
Color kGreyMedium= const Color(0xFFC4C4C4);
Color kGreen= const Color(0xFF1CAF5E);
Color kOrange = const Color(0xFFFFA800);
Color kDeepOrange = const Color(0xFFFF5F2D);

Color kShadowColor = const Color(0xFF616161).withOpacity(0.18);
Color kItemShadowColor = const Color(0xFF000000).withOpacity(0.10);
Color kGreyTextColor = const Color(0xFFA5A5A5);
Color kDividerColor = const Color(0xFFE8ECF2);
Color kBlueGrey = const Color(0xFF7D8FAB);

Color kAppBarGradientColor1 = const Color(0xFF142127);
Color kAppBarGradientColor2 = const Color(0xFF2c2626);

Color mainColor = const Color(0xFF047da1);

Color successColor = Colors.green;
Color failedColor = Colors.red;
Color warningColor = Colors.orange;

Color kLightBgColor = Colors.white;
Color? kDarkBgColor = Colors.blueGrey[900];




Map<int, Color> color =
  const {
    50:Color.fromRGBO(4,125,161, .1),
    100:Color.fromRGBO(4,125,161, .2),
    200:Color.fromRGBO(4,125,161, .3),
    300:Color.fromRGBO(4,125,161, .4),
    400:Color.fromRGBO(4,125,161, .5),
    500:Color.fromRGBO(4,125,161, .6),
    600:Color.fromRGBO(4,125,161, .7),
    700:Color.fromRGBO(4,125,161, .8),
    800:Color.fromRGBO(4,125,161, .9),
    900:Color.fromRGBO(4,125,161, 1),
  };

MaterialColor kLightPrimarySwatchColor = MaterialColor(0xFF047da1, color);
