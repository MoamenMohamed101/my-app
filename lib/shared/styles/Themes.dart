import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lighttheme = ThemeData(
  primarySwatch: primryswatsh,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primryswatsh,
    elevation: 50.0,
    backgroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    color: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    subtitle1: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,height: 1.3),
  ),
  //fontFamily: 'Fira_Sans'
);

ThemeData darktheme = ThemeData(
  primarySwatch: primryswatsh,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 50.0,
    backgroundColor: HexColor('333739'),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    actionsIconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light),
    color: HexColor('333739'),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    subtitle1: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white,height: 1.3),
  ),
  //fontFamily: 'Fira_Sans'
);
