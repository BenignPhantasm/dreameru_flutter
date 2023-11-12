import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  bool _isShiftPressed(RawKeyEvent event) {
    return event.isShiftPressed;
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (!_isShiftPressed(event)) {
          _handleSubmitted(_textController.text);
        }
      }
    }
  }

  void _removeExtraNewLine(String value) {
    if(re.hasMatch(value)){
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat App")),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const CircleAvatar(child: Text("Te")),
                const SizedBox(width: 8),
                Expanded(
                  child: RawKeyboardListener(
                    focusNode: _focusNode,
                    onKey: _handleKeyEvent,
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(hintText: "Enter message"),
                      onSubmitted: (value) => _handleSubmitted(value),
                      maxLines: null,
                      onChanged: _removeExtraNewLine,
                    ),
                  )
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}