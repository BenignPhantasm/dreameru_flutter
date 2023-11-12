import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'message_input_field.dart';

void main() {
  runApp(const MyChatApp());
}

ColorScheme myAppColorScheme = const ColorScheme(
  // Dark theme base colors
  brightness: Brightness.dark,
  background: Color(0xFF1E1E2E),  // Dark background for screens
  surface: Color(0xFF2A2A37),     // Slightly lighter background for elements like Card

  // Primary color used for AppBar, FloatingActionButtons, and more
  primary: Color(0xFFC8BAF7),      // Pastel purple as the main accent color
  onPrimary: Color(0xFFCDD6F4),    // Text color on top of primary color

  // Secondary color for widgets like FloatingActionButton, Switch, etc.
  secondary: Color(0xFF89DCEB),    // Pastel sky blue as secondary color
  onSecondary: Color(0xFF1E1E2E),  // Dark color for text/icons on top of secondary color

  // Error color for use in input validation and other 'error' scenarios
  error: Color(0xFFF28B82),        // Soft pastel red for errors
  onError: Color(0xFF1E1E2E),      // Dark color for text/icons on top of error color

  // Additional colors for different parts of your UI
  // secondaryVariant: Color(0xFF94E2D5), // Pastel mint for secondary variant
  // primaryVariant: Color(0xFFC8BAF7),   // Lighter pastel purple for primary variant

  // Background/text contrast
  onBackground: Color(0xFFCDD6F4),    // Text color on top of background
  onSurface: Color(0xFFCDD6F4),       // Text color on surfaces

  // Additional accent colors
  tertiary: Color(0xFFF5C2E7),        // Pastel pink for tertiary color
  tertiaryContainer: Color(0xFFFAE3B0), // Pastel yellow for tertiary containers

  // Typically, you might want to have a slightly off-white shade
  onTertiary: Color(0xFF1E1E2E),     // Dark color for text/icons on top of tertiary color

  // Success and warning colors (not directly part of ColorScheme, but good to define)
  // Success: const Color(0xFFA6E3A1),     // Pastel green for success indicators
  // Warning: const Color(0xFFFFB374),     // Pastel orange for warnings
);

ThemeData darkTheme = ThemeData(
  colorScheme: myAppColorScheme,
  scaffoldBackgroundColor: const Color(0xFF1E1E2E),  // Dark background for screens
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFCDD6F4)),
    bodyMedium:  TextStyle(color: Color(0xFFCDD6F4)),
  ),
);

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: ChatScreen(key: GlobalKey()),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var re = RegExp(r"\s*\n\s*");

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textController.clear();
      setState(() {
        _messages.add(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dreameru")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, index) => ListTile(
                title: Text(_messages[index]),
              ),
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          MessageInputField(
            onSubmitted: _handleSubmitted,
            controller: _textController,
            focusNode: _focusNode
          )
        ],
      ),
    );
  }
}
