import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final List<String> messages;

  const Conversation({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State createState() => ConversationState();
}

class ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        reverse: false,
        itemBuilder: (_, index) => ListTile(
          title: Text(widget.messages[index],
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        itemCount: widget.messages.length,
      ),
    );
  }
}
