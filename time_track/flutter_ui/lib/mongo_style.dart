import 'package:flutter/material.dart';

const black = Color.fromRGBO(8, 29, 42, 1);
const darkGreen = Color.fromRGBO(19, 51, 48, 1);
const forestGreen = Color.fromRGBO(45, 96, 75, 1);
const green = Color.fromRGBO(78, 166, 92, 1);
const terminalGreen = Color.fromRGBO(108, 232, 117, 1);
const limeGreen = Color.fromRGBO(192, 251, 81, 1);
const blue = Color.fromRGBO(39, 110, 241, 1);
const lightBlue = Color.fromRGBO(93, 208, 250, 1);
const grey = Color.fromRGBO(184, 184, 184, 1);
const white = Color.fromRGBO(255, 255, 255, 1);
const red = Colors.red;

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: forestGreen,
  onPrimary: white,
  secondary: terminalGreen,
  onSecondary: black,
  error: Colors.red,
  onError: white,
  background: white,
  onBackground: black,
  surface: limeGreen,
  onSurface: forestGreen,
);

final lightTheme = ThemeData.from(colorScheme: lightColorScheme);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: terminalGreen,
  onPrimary: black,
  secondary: limeGreen,
  onSecondary: black,
  error: Colors.red,
  onError: white,
  background: black,
  onBackground: white,
  surface: forestGreen,
  onSurface: white,
);

final darkTheme = ThemeData.from(colorScheme: darkColorScheme);