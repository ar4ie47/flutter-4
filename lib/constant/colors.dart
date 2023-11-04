import 'package:flutter/material.dart';

class DarkColors {
  static const shadowLight = Colors.white12;
  static const shadowDark = Colors.black38;
  static const primary = Color(0xFFE2E6EB);
  static const background = Color(0xFF25272c);
  static const unselectedIcon = Color(0xFF616161);
  static const redIcon = Color(0xffad2033);
  static const greenIcon = Color(0xff02956a);

  static const snackBarWarn = Color(0xFFef8d32);
  static const snackBarInfo = Color(0xFF3382b7);
  static const snackBarSuccess = Color(0xff08572f);
  static const snackBarError = Color(0xffff7082);
}

List<BoxShadow> getShadows() {
  return [
    const BoxShadow(
        color: DarkColors.shadowLight,
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(-3, -3)),
    const BoxShadow(
        color: DarkColors.shadowDark,
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(3, 3))
  ];
}
