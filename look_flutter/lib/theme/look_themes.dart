import 'package:flutter/material.dart';
import 'package:look_flutter/res/colors_manager.dart';

///通过 Get.changeTheme(LookThemes.black); 的方式进行主题选择
class LookThemes {

  static final defaultTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorManager.main,
      appBarTheme: const AppBarTheme(
          backgroundColor: ColorManager.main,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange))));

  static final green = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30))),
  );

  static final yellow = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.yellow,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange))));

  static final red = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.red,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown))));

  static final black = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));

  static final white = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.black, fontSize: 30))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));
}
