import 'package:flutter/material.dart';

const pastelDarkBlue = 0xFF1E1E2E;
const pastelDarkLavender = 0xFF2A2A37;
const pastelDarkPlum = 0xFF312A4A;
const pastelDarkSlatePurple = 0xFF423B58;
const pastelDeepPurple = 0xFFA991F7;
const pastelLavender = 0xFFCDD6F4;
const pastelPink = 0xFFF5C2E7;
const pastelSkyBlue = 0xFF89DCEB;
const pastelRed = 0xFFF28B82;
const pastelOrange = 0xFFFFB374;
const pastelMint = 0xFF94E2D5;
const pastelGreen = 0xFFA6E3A1;
const pastelYellow = 0xFFFAE3B0;
const pastelLightPurple = 0xFFC8BAF7;

ColorScheme myAppColorScheme = const ColorScheme(
  // Dark theme base colors
  brightness: Brightness.dark,
  background: Color(pastelDarkBlue),
  surface: Color(pastelDarkLavender),

  // Primary color used for AppBar, FloatingActionButtons, and more
  primary: Color(pastelLightPurple),
  onPrimary: Color(pastelLavender),

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
  onBackground: Color(pastelLavender),
  onSurface: Color(pastelLavender),

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
  cardTheme: const CardTheme(color: Color(pastelDarkPlum)),
  scaffoldBackgroundColor:
      const Color(pastelDarkBlue), // Dark background for screens
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(pastelLavender), fontSize: 16),
    bodyMedium: TextStyle(color: Color(pastelLavender)),
    bodySmall: TextStyle(color: Color(pastelLavender)),
    labelLarge: TextStyle(color: Color(pastelLavender)),
  ),
);
