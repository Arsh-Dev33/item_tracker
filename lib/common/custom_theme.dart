import 'package:flutter/material.dart';

class BlackTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        primaryColorDark: Colors.black87,
        primaryColorLight: Colors.black54,
        dividerColor: Colors.grey,
        canvasColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff4c348c),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}
