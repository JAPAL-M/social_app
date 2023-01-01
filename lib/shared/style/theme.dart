import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

var themDark = ThemeData(
    fontFamily: 'Janna',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: PrimaryColor,
    appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0.0,
        color: HexColor('333739'),
        iconTheme: const IconThemeData(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: PrimaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      elevation: 5.0,
    )
);
var themLight = ThemeData(
    fontFamily: 'Janna',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
    ),
    primarySwatch: PrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        color: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 5.0,
    )
);