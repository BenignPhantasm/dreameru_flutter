import 'package:dreameru_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dreameru_flutter/main.dart';
import 'package:dreameru_flutter/character_list.dart';
import 'conversation.dart';

class MessageInputField extends ConsumerStatefulWidget {
  final Function(Message) onSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;

  const MessageInputField({
    Key? key,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  MessageInputFieldState createState() => MessageInputFieldState();
}

class MessageInputFieldState extends ConsumerState<MessageInputField> {
  void _removeExtraNewLine(String value) {
    var re = RegExp(r"\s*\n\s*");
    if (re.stringMatch(value) == value) {
      widget.controller.clear();
    }
  }

  final activeCharacterProvider = Provider<Character>((ref) {
    ref.watch(characterListProvider);
    return ref.read(characterListProvider.notifier).getActiveCharacter();
  });

  @override
  Widget build(BuildContext context) {
    Character activeCharacter = ref.watch(activeCharacterProvider);
    void handleKeyEvent(RawKeyEvent event) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          if (!event.isShiftPressed) {
            Message message = Message(
                message: widget.controller.text, character: activeCharacter);
            widget.onSubmitted(message);
          }
        }
      }
    }

    Message buildMessage(String value) {
      return Message(message: value, character: activeCharacter);
    }

    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(children: [
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  CircleAvatar(
                      child: Text(activeCharacter.name.isNotEmpty
                          ? activeCharacter.name.substring(0, 2)
                          : "?")),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RawKeyboardListener(
                      focusNode: widget.focusNode,
                      onKey: handleKeyEvent,
                      child: TextField(
                          controller: widget.controller,
                          decoration:
                              const InputDecoration(hintText: "Enter message"),
                          onSubmitted: (value) =>
                              widget.onSubmitted(buildMessage(value)),
                          maxLines: null,
                          onChanged: _removeExtraNewLine,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => widget
                        .onSubmitted(buildMessage(widget.controller.text)),
                    color: const Color(white),
                  ),
                ],
              ),
            ])));
  }
}
