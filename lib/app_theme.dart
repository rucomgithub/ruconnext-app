import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const MaterialColor myColor = MaterialColor(0xFFffffff, {
    50: Color(0xFF7171a4),
    100: Color(0xFF525290),
    200: Color(0xFF34347d),
    300: Color(0xFF2d2d78),
    400: Color(0xFF272774),
    500: Color(0xFF202070),
    600: Color(0xFF1a1a6c),
    700: Color(0xFF161660),
    800: Color(0xFF131353),
    900: Color(0xFF101042),
  });

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF7171a4);
  static const Color dark_grey = Color(0xFF34347d);

  //สีแอพ
  static const Color ru_dark_blue = Color(0xFF19196B);
  static const Color ru_yellow = Color(0xFFf6c543);
  static const Color ru_grey = Color(0xFF7171a4);
  static const Color ru_text_light_blue = Color(0xFF0B14E0);
  static const Color ru_text_grey = Color(0xFF656565);
  static const Color ru_text_ocean_blue = Color(0xFF34347d);
  static const Color background = Color(0xFFFEFEFE);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  //static const String fontName = 'KanitRegular';
  //static const String fontName = 'KanitRegular';
  static const String ruFontKanit = 'KanitRegular';
  static const String ruFontCharm = 'Charm';

  static const TextTheme textTheme = TextTheme(
    headlineMedium: display1,
    headlineSmall: headline,
    titleLarge: title,
    titleSmall: subtitle,
    bodyMedium: body2,
    bodyLarge: body1,
    bodySmall: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w900,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyWhite,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    letterSpacing: 0.27,
    color: nearlyWhite,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: ruFontKanit,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: nearlyWhite,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: nearlyWhite,
  );

  static const TextStyle content = TextStyle(
    fontFamily: ruFontKanit,
    overflow: TextOverflow.ellipsis,
    fontSize: 14,
    color: nearlyWhite,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle cardNameBlue = TextStyle(
    // body2 -> body1
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: ru_dark_blue,
  );

  static const TextStyle cardNameYellow = TextStyle(
    // body2 -> body1
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: ru_yellow,
  );

  static const TextStyle header = TextStyle(
    // body2 -> body1
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle cardHeader = TextStyle(
    // h6 -> title
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
    fontSize: 14,
    letterSpacing: 0.24,
    color: nearlyWhite,
  );

  static const TextStyle cardFooter = TextStyle(
    // h6 -> title
    fontFamily: ruFontKanit,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    fontSize: 14,
    letterSpacing: 0.24,
    color: ru_yellow,
  );

  static const TextStyle cardTitle = TextStyle(
    // h6 -> title
    fontFamily: ruFontKanit,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: ru_yellow,
  );

  static const TextStyle cardContent = TextStyle(
    fontFamily: ruFontKanit,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.24,
    fontSize: 12,
    color: nearlyWhite,
  );
}
