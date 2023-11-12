import 'package:flutter/material.dart';
import 'theme.dart';

class Character {
  final String name;
  final String gender;
  final String personality;
  final String background;

  Character({
    required this.name,
    required this.gender,
    required this.personality,
    required this.background,
  });
}

class CharacterList extends StatelessWidget {
  final List<Character> characters;

  const CharacterList({
    Key? key,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (_, index) => CharacterCard(character: characters[index]),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          // The avatar could be an icon or image. Here's an example using initials.
          child: Text(
              character.name.isNotEmpty ? character.name.substring(0, 3) : '?'),
        ),
        title: Text(character.name),
        subtitle: Row(
          children: [
            OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(pastelGreen)),
                ),
                child: const Text("Generate turn",
                    style: TextStyle(color: Color(pastelGreen)))),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _characterEditDialog(context),
              color: const Color(pastelLavender),
            )
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Future<void> _characterEditDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
              title: Text("modal please"),
              backgroundColor: Color(pastelDarkLavender),
              content: SingleChildScrollView(
                child: ListBody(children: [TextField()]),
              ));
        });
  }
}
