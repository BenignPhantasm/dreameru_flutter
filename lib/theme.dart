import 'package:flutter/material.dart';

const pastelDarkBlue = 0xFF1E1E2E;
const pastelDarkLavender = 0xFF2A2A37;
const pastelMutedPurple = 0xFF383447;
const white = 0xFFFFFFFF;
//const pastelLightLavender = 0xFFF1EDFF; // Hue is 254 out of 360 degrees
const pastelGreen = 0xFFA6E3A1;
//const pastelGreen = 0xFFA6F373;
const pastelPink = 0xFFF5C2E7;
const pastelSkyBlue = 0xFF89DCEB;
const pastelRed = 0xFFF28B82;
const pastelYellow = 0xFFFAE3B0;
const pastelLightPurple = 0xFFC8BAF7;
//const pastelDarkPlum = 0xFF312A4A;
//const pastelDarkSlatePurple = 0xFF423B58;
//const pastelDeepPurple = 0xFFA991F7;
//const pastelLavender = 0xFFCDD6F4;
//const pastelOrange = 0xFFFFB374;
//const pastelMint = 0xFF94E2D5;

ColorScheme myAppColorScheme = const ColorScheme(
  // Dark theme base colors
  brightness: Brightness.dark,
  background: Color(pastelDarkBlue),
  surface: Color(pastelDarkLavender),

  // Primary color used for AppBar, FloatingActionButtons, and more
  primary: Color(pastelLightPurple),
  onPrimary: Color(white),

  // Secondary color for widgets like FloatingActionButton, Switch, etc.
  secondary: Color(pastelSkyBlue),
  onSecondary: Color(pastelDarkBlue),

  // Error color for use in input validation and other 'error' scenarios
  error: Color(pastelRed),
  onError: Color(pastelDarkBlue),

  // Additional colors for different parts of your UI
  // secondaryVariant: Color(0xFF94E2D5),
  // primaryVariant: Color(pastelLightPurple),

  // Background/text contrast
  onBackground: Color(white),
  onSurface: Color(white),

  // Additional accent colors
  tertiary: Color(pastelPink),
  tertiaryContainer: Color(pastelYellow),

  // Typically, you might want to have a slightly off-white shade
  onTertiary: Color(pastelDarkBlue),

  // Success and warning colors (not directly part of ColorScheme, but good to define)
  // Success: const Color(0xFFA6E3A1),
  // Warning: const Color(0xFFFFB374),
);

ThemeData darkTheme = ThemeData(
  colorScheme: myAppColorScheme,
  cardTheme: const CardTheme(color: Color(pastelMutedPurple)),
  popupMenuTheme: const PopupMenuThemeData(color: Color(pastelDarkBlue)),
  scaffoldBackgroundColor:
      const Color(pastelDarkBlue), // Dark background for screens
  textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
      //bodyMedium: TextStyle(),
      //bodySmall: TextStyle(),
      //labelLarge: TextStyle(),
      ),
);
