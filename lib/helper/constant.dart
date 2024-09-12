import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyIcons{
  MyIcons._();
  static const String statusRejected = 'assets/icons/ic_status_rejected.png';
  static const String addCircleBlue = 'assets/icons/ic_plus_circle_blue.png';
}

class MyColors{
  MyColors._();
  static const Color mediumGray = Color.fromRGBO(203, 201, 203, 1.0);
  static const Color darkGray = Color.fromRGBO(115, 117, 117, 1);
  static const Color mbBlue = Color.fromRGBO(31, 55, 93, 1.0);
  static const Color grayBright = Color.fromRGBO(210, 215, 222, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color darkBlue2 = Color.fromRGBO(12, 76, 138, 1.0);
  static const Color errorColor = Color.fromRGBO(236, 28, 36, 1);
  static const Color menuColor = Color.fromRGBO(99, 106, 119, 1);
  static const Color lightBlack = Color.fromRGBO(34, 36, 46, 1);
  static const Color secondaryColor = Color.fromRGBO(99, 106, 119, 1);
  static const Color gray = Color.fromRGBO(151, 151, 151, 1);
  static const Color transparent = Color.fromRGBO(255, 255, 255, 0.0);
  static const Color blueSea = Color.fromRGBO(73, 158, 237, 1);
}

class MyFontFamily {
  MyFontFamily._();

  static const String defaultButton = mulish;

  static const String mulish = 'Mulish';
  static const String scada = 'Scada';
}

class MyFontSize {
  MyFontSize._();

  static const double smallest = 9;
  static const double small = 11;
  static const double medium = 13;
  static const double standard = 15;
  static const double big = 18;
  static const double large = 20;
  static const double extraLarge = 25;
  static const double giant = 30;
}

class MyMargin {
  MyMargin._();

  static const double tiny = 4;
  static const double small = 8;
  static const double medium = 16;
  static const double standard = 24;
  static const double big = 32;
  static const double large = 40;
  static const double extraLarge = 48;
  static const double giant = 56;

  static const EdgeInsetsGeometry bodyMargin = EdgeInsets.symmetric(
    horizontal: medium,
  );
  static const EdgeInsetsGeometry bodyScrollMargin = EdgeInsets.only(
    left: medium,
    right: medium,
    bottom: medium,
  );
  static const EdgeInsetsGeometry footerMargin = EdgeInsets.only(
    left: medium,
    right: medium,
    top: medium,
    bottom: small,
  );
}
