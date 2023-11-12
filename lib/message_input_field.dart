import 'package:dreameru_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageInputField extends StatefulWidget {
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;

  const MessageInputField({
    Key? key,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (!event.isShiftPressed) {
          widget.onSubmitted(widget.controller.text);
        }
      }
    }
  }

  void _removeExtraNewLine(String value) {
    var re = RegExp(r"\s*\n\s*");
    if (re.stringMatch(value) == value) {
      widget.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          const CircleAvatar(child: Text("Te")),
          const SizedBox(width: 8),
          Expanded(
            child: RawKeyboardListener(
              focusNode: widget.focusNode,
              onKey: _handleKeyEvent,
              child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(hintText: "Enter message"),
                  onSubmitted: (value) => widget.onSubmitted(value),
                  maxLines: null,
                  onChanged: _removeExtraNewLine,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => widget.onSubmitted(widget.controller.text),
            color: const Color(pastelLightLavender),
          ),
        ],
      ),
    ));
  }
}
