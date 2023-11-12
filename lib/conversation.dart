import 'package:flutter/material.dart';
import "character_list.dart";

class Message {
  final String message;
  final Character character;

  Message({required this.message, required this.character});
}

class Conversation extends StatefulWidget {
  final List<Message> messages;

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
        itemBuilder: (_, index) {
          Message message = widget.messages[index];
          return Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Text(message.character.name.isNotEmpty
                      ? message.character.name.substring(0, 2)
                      : '?'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message.character.name,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 5),
                        Text(
                          message.message,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: null,
                        ),
                      ]),
                )
              ],
            ),
            const SizedBox(height: 10),
          ]);
        },
        itemCount: widget.messages.length,
      ),
    );
  }
}
