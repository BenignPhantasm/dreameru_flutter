import 'package:dreameru_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';

enum Gender { male, female }

class Character {
  final String name;
  final Gender gender;
  final String personality;
  final String background;
  final bool isControlled;

  Character(
      {required this.name,
      required this.gender,
      required this.personality,
      required this.background,
      required this.isControlled});

  Character copyWith({
    String? name,
    Gender? gender,
    String? personality,
    String? background,
    bool? isControlled,
  }) {
    return Character(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      personality: personality ?? this.personality,
      background: background ?? this.background,
      isControlled: isControlled ?? this.isControlled,
    );
  }
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
    Color borderColor = const Color(0x00000000);
    if (widget.character.isControlled == true) {
      borderColor = const Color(pastelYellow);
    }
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.character.name.isNotEmpty
              ? widget.character.name.substring(0, 2)
              : '?'),
        ),
        title: Text(
          widget.character.name,
        ),
        subtitle: Row(
          children: [
            OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(pastelGreen)),
                ),
                child: const Text("Generate turn",
                    style: TextStyle(color: Color(pastelGreen)))),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                      value: "edit", child: Text("Edit Character")),
                  const PopupMenuItem(
                      value: "control", child: Text("Control Character")),
                  const PopupMenuItem(
                      value: "delete", child: Text("Delete Character")),
                ];
              },
              onSelected: (value) {
                if (value == "edit") {
                  _characterEditDialog(context);
                } else if (value == "control") {
                  ref
                      .read(characterListProvider.notifier)
                      .controlCharacter(widget.character);
                } else if (value == "delete") {
                  ref
                      .read(characterListProvider.notifier)
                      .removeCharacter(widget.character);
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
    //final TextEditingController characterGenderController =
    //TextEditingController(text: widget.character.gender);
    final TextEditingController characterPersonalityController =
        TextEditingController(text: widget.character.personality);

    void saveCharacter(Gender inputGender) {
      Character newCharacter = Character(
          name: characterNameController.text,
          background: characterBackgroundController.text,
          //gender: characterGenderController.text,
          gender: inputGender,
          personality: characterPersonalityController.text,
          isControlled: false);

      ref
          .read(characterListProvider.notifier)
          .editCharacter(widget.character, newCharacter);
      Navigator.pop(context);
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Gender gender = widget.character.gender;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Character Information"),
              backgroundColor: const Color(pastelDarkLavender),
              content: SingleChildScrollView(
                child: ListBody(children: [
                  TextField(
                      decoration: const InputDecoration(labelText: "Name"),
                      controller: characterNameController),
                  DropdownButton<String>(
                    dropdownColor: const Color(pastelDarkBlue),
                    value: gender.name,
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem<String>(
                        value: gender.name,
                        child: Text(gender.name),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = Gender.values.byName(newValue!);
                      });
                    },
                  ),
                  //TextField(
                  //    decoration: const InputDecoration(labelText: "Gender"),
                  //    controller: characterGenderController),
                  TextField(
                      decoration: const InputDecoration(
                          labelText: "Personality Traits"),
                      controller: characterPersonalityController),
                  TextField(
                      decoration:
                          const InputDecoration(labelText: "Background"),
                      controller: characterBackgroundController,
                      maxLines: null),
                ]),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      saveCharacter(gender);
                    },
                    child: const Text("save")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel",
                        style: TextStyle(color: Color(pastelRed)))),
              ],
            );
          });
        });
  }
}
