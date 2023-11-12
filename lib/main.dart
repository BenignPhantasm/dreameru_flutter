import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'message_input_field.dart';
import 'theme.dart';
import 'conversation.dart';
import 'character_list.dart';
import 'dart:async';
import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

class CharacterListNotifier extends StateNotifier<List<Character>> {
  late Character _activeCharacter;

  CharacterListNotifier() : super([]) {
    addCharacter(Character(
        name: "Eira",
        gender: Gender.female,
        personality: "nervous, unrefined, intelligent",
        background:
            "Raised in a humble backwater village by her healer grandmother, Eira possesses a raw talent for healing magic, yet her fear of failure and the unknown prevents her from pursuing her full potential.",
        isControlled: true));
    addCharacter(Character(
        name: "Alice",
        gender: Gender.female,
        personality: "rational, calm, pedantic",
        background:
            "Alice, a counselor by training, prefers the quiet orderliness of a research library over the unpredictable chaos of human emotions.",
        isControlled: false));
    addCharacter(Character(
        name: "Hank",
        gender: Gender.male,
        personality: "enthusiastic, pragmatic, brazen",
        background:
            "Hank is a gritty sailor, adept at ferry calibrations and known for his brazen personality. His volatile moods and a knack for speaking bluntly have given him an infamous reputation along the seaports.",
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

class WebSocketManager {
  late WebSocket _socket;

  Future<void> connect(String url) async {
    try {
      // Connect to the WebSocket server.
      _socket = await WebSocket.connect(url);

      // Listen for responses from the server.
      _socket.listen(
        (data) {
          // Handle the received data.
          print('Received data: $data');
        },
        onDone: () {
          // Handle the WebSocket closing.
          print('WebSocket connection closed.');
          // Optionally attempt to reconnect here...
        },
        onError: (error) {
          // Handle errors or a disconnected WebSocket.
          print('Error on WebSocket: $error');
          // Optionally attempt to reconnect here...
        },
        cancelOnError: true,
      );
    } catch (e) {
      // Handle the error from trying to connect to the WebSocket.
      print('Could not connect to the WebSocket: $e');
    }
  }

  void send(String message) {
    if (_socket.readyState == WebSocket.open) {
      _socket.add(message);
      print('Sent data: $message');
    } else {
      // Handle the case where the WebSocket is not open.
      print('WebSocket is not connected.');
    }
  }

  void dispose() {
    _socket.close();
  }
}

void main() {
  // final WebSocketManager webSocketManager = WebSocketManager();
  // await webSocketManager.connect('ws://localhost:8765');
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8765'));

  WidgetsFlutterBinding.ensureInitialized();

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
  final List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var re = RegExp(r"\s*\n\s*");

  void _handleSubmitted(Message message) {
    //Message message = Message(message: text, character: Character({}))
    if (message.message.isNotEmpty) {
      _textController.clear();
      setState(() {
        _messages.add(message);
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
