import 'package:dreameru_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class CharacterList extends ConsumerWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Character> characters = ref.watch(characterListProvider);
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (_, index) => CharacterCard(character: characters[index]),
    );
  }
}

class CharacterCard extends ConsumerStatefulWidget {
  const CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  CharacterCardState createState() => CharacterCardState();
}

class CharacterCardState extends ConsumerState<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.character.name.isNotEmpty
              ? widget.character.name.substring(0, 3)
              : '?'),
        ),
        title: Text(widget.character.name,
            style: const TextStyle(color: Color(pastelLightLavender))),
        subtitle: Row(
          children: [
            OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(pastelGreen)),
                ),
                child: const Text("Generate turn",
                    style: TextStyle(color: Color(pastelGreen)))),
            //IconButton(
            //  icon: const Icon(Icons.settings),
            //  onPressed: () => _characterEditDialog(context),
            //  color: const Color(pastelLightLavender),
            //)
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                      value: "edit", child: Text("Edit Character"))
                ];
              },
              onSelected: (value) {
                if (value == "edit") {
                  _characterEditDialog(context);
                }
              },
            )
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Future<void> _characterEditDialog(BuildContext context) {
    final TextEditingController characterNameController =
        TextEditingController(text: widget.character.name);
    final TextEditingController characterBackgroundController =
        TextEditingController(text: widget.character.background);
    final TextEditingController characterGenderController =
        TextEditingController(text: widget.character.gender);
    final TextEditingController characterPersonalityController =
        TextEditingController(text: widget.character.personality);

    void saveCharacter() {
      Character newCharacter = Character(
          name: characterNameController.text,
          background: characterBackgroundController.text,
          gender: characterGenderController.text,
          personality: characterPersonalityController.text);

      ref
          .read(characterListProvider.notifier)
          .editCharacter(widget.character, newCharacter);
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Character Information"),
            backgroundColor: const Color(pastelDarkLavender),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextField(
                    decoration: const InputDecoration(labelText: "Name"),
                    controller: characterNameController),
                TextField(
                    decoration: const InputDecoration(labelText: "Gender"),
                    controller: characterGenderController),
                TextField(
                    decoration:
                        const InputDecoration(labelText: "Personality Traits"),
                    controller: characterPersonalityController),
                TextField(
                    decoration: const InputDecoration(labelText: "Background"),
                    controller: characterBackgroundController,
                    maxLines: null),
              ]),
            ),
            actions: <Widget>[
              TextButton(onPressed: saveCharacter, child: const Text("save")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel",
                      style: TextStyle(color: Color(pastelRed)))),
            ],
          );
        });
  }
}
