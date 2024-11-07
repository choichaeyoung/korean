import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
class Constants {
  //App related strings
  static String appName = "한국어학당";

  //#2C8F92
  //Colors for theme
  static Color mainPrimary = Color(0xff75c5c1);
  static Color mainBTN = Color(0xff2C8F92);
  static Color bggrey = Color(0xffD9D9D9);
  static Color linegrey = Color(0xffCBCBCB);
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff2B2B2B);

  static Color lightAccent = Color(0xff75c5c1);

  static Color darkAccent =Color(0xff75c5c1);

  //static Color lightBG = Color(0xfff3f4f9);
  static Color lightBG = Colors.white;
  static Color darkBG = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    dialogBackgroundColor: lightBG,
    primaryColor: lightPrimary,
    fontFamily: "PretendardVariable",
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightAccent,
    ),
    scaffoldBackgroundColor: lightBG,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: lightBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: lightBG,
      iconTheme: const IconThemeData(color: Colors.black),

    ),

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: lightAccent,
    ),
    textTheme: const TextTheme(
      /*headline1: TextStyle(
        color: Colors.black,
        fontSize: 42,
        fontWeight: FontWeight.bold,
        fontFamily: "PretendardVariable",
      ),
      headline2: TextStyle(
        color: Colors.black87,
        fontSize: 28,
        fontStyle: FontStyle.italic,
        fontFamily: "PretendardVariable",
      ),
      bodyText1: TextStyle(
        fontSize: 16,
      ),*/
    ),
  );

  static ThemeData darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: darkAccent,
    ).copyWith(
      secondary: darkAccent,
      brightness: Brightness.dark,
    ),
    dialogBackgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    textSelectionTheme: TextSelectionThemeData(

      cursorColor: darkAccent,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: darkBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: darkBG,
      iconTheme: const IconThemeData(color: Colors.white),


    ),
  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

}
