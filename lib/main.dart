import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'message_input_field.dart';
import 'theme.dart';
import 'conversation.dart';
import 'character_list.dart';

class CharacterListNotifier extends StateNotifier<List<Character>> {
  late Character _activeCharacter;

  CharacterListNotifier() : super([]) {
    addCharacter(Character(
        name: "Bob",
        background: "background blah",
        gender: "gender blah",
        personality: "personality blah",
        isControlled: true));
    addCharacter(Character(
        name: "Alice",
        background: "background blah",
        gender: "gender blah",
        personality: "personality blah",
        isControlled: false));
    addCharacter(Character(
        name: "John",
        background: "background blah",
        gender: "gender blah",
        personality: "personality blah",
        isControlled: false));
    _activeCharacter = state[0];
  }

  void addCharacter(Character character) {
    state = [...state, character];
  }

  void removeCharacter(Character character) {
    state = state.where((Character currChar) => currChar != character).toList();

    if (character == _activeCharacter) {
      _activeCharacter = state[0];
    }
  }

  void controlCharacter(Character character) {
    state = state.map((currChar) {
      if (currChar == character) {
        _activeCharacter = currChar.copyWith(isControlled: true);
        return _activeCharacter;
      }
      return currChar.copyWith(isControlled: false);
    }).toList();
  }

  void editCharacter(Character character, Character newCharacter) {
    state = state.map((currChar) {
      if (currChar == character) {
        return newCharacter;
      }
      return currChar;
    }).toList();
  }

  Character getActiveCharacter() {
    return _activeCharacter;
  }
}

final characterListProvider =
    StateNotifierProvider<CharacterListNotifier, List<Character>>((ref) {
  return CharacterListNotifier();
});

void main() {
  runApp(const ProviderScope(child: Dreameru()));
}

class Dreameru extends ConsumerWidget {
  const Dreameru({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        const Expanded(flex: 1, child: CharacterList())
      ]),
    );
  }
}
