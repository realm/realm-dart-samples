import 'package:flutter/material.dart';

appThemeData() {
  return ThemeData(
          primarySwatch: forestGreenColor,
          backgroundColor: mistColor,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: forestGreenColor),
          errorColor: darkRedColor)
      .copyWith(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(forestGreenColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white)),
      ),
    ),
  );
}

headerFooterBoxDecoration(BuildContext context, bool isHeader) {
  final theme = Theme.of(context);
  return BoxDecoration(
    color: theme.backgroundColor,
    border: Border(
        top: isHeader
            ? BorderSide.none
            : BorderSide(width: 2, color: theme.primaryColor),
        bottom: isHeader
            ? BorderSide(width: 2, color: theme.primaryColor)
            : BorderSide.none),
  );
}

errorBoxDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: theme.backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(8)));
}

infoBoxDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: theme.backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(8)));
}

errorTextStyle(BuildContext context, {bool bold = false}) {
  final theme = Theme.of(context);
  return TextStyle(
      color: theme.errorColor,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

infoTextStyle(BuildContext context, {bool bold = false}) {
  return TextStyle(
      color: Colors.black,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

boldTextStyle() {
  return const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}

MaterialColor forestGreenColor = MaterialColor(
  const Color.fromRGBO(0, 104, 74, 1).value,
  const <int, Color>{
    50: Color.fromRGBO(0, 104, 74, 0.1),
    100: Color.fromRGBO(0, 104, 74, 0.2),
    200: Color.fromRGBO(0, 104, 74, 0.3),
    300: Color.fromRGBO(0, 104, 74, 0.4),
    400: Color.fromRGBO(0, 104, 74, 0.5),
    500: Color.fromRGBO(0, 104, 74, 0.6),
    600: Color.fromRGBO(0, 104, 74, 0.7),
    700: Color.fromRGBO(0, 104, 74, 0.8),
    800: Color.fromRGBO(0, 104, 74, 0.9),
    900: Color.fromRGBO(0, 104, 74, 1),
  },
);

MaterialColor mistColor = MaterialColor(
  const Color.fromRGBO(227, 252, 247, 1).value,
  const <int, Color>{
    50: Color.fromRGBO(227, 252, 247, 0.1),
    100: Color.fromRGBO(227, 252, 247, 0.2),
    200: Color.fromRGBO(227, 252, 247, 0.3),
    300: Color.fromRGBO(227, 252, 247, 0.4),
    400: Color.fromRGBO(227, 252, 247, 0.5),
    500: Color.fromRGBO(227, 252, 247, 0.6),
    600: Color.fromRGBO(227, 252, 247, 0.7),
    700: Color.fromRGBO(227, 252, 247, 0.8),
    800: Color.fromRGBO(227, 252, 247, 0.9),
    900: Color.fromRGBO(227, 252, 247, 1),
  },
);

Color get darkRedColor => Color.fromARGB(255, 208, 18, 5);
Color get lightRedColor => const Color.fromARGB(255, 244, 223, 221);
