import 'package:flutter/material.dart';
import 'message_input_field.dart';
import 'theme.dart';
import 'conversation.dart';
import 'character_list.dart';

void main() {
  runApp(const Dreameru());
}

class Dreameru extends StatelessWidget {
  const Dreameru({super.key});

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
  final List<Character> _characters = [
    Character(
        name: "Name Blah",
        background: "background blah",
        gender: "gender blah",
        personality: "personality blah")
  ];
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
      body: Row(children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Conversation(
                messages: _messages,
              ),
              const Divider(height: 1.0, color: Color(0x00000000)),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, left: 8, right: 8, top: 8),
                  child: MessageInputField(
                      onSubmitted: _handleSubmitted,
                      controller: _textController,
                      focusNode: _focusNode))
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(flex: 1, child: CharacterList(characters: _characters))
      ]),
    );
  }
}
