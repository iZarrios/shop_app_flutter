import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // fontFamily: "Poppins",
);

ThemeData lightTheme = ThemeData(
  // fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    // IconTheme:
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black38,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  primarySwatch: Colors.blue,
  // floatingActionButtonTheme:
  //     FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    elevation: 20,
    type: BottomNavigationBarType.fixed,
  ),
);
