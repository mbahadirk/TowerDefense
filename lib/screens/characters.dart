import 'package:flutter/material.dart';

class Character extends StatefulWidget {
  final ValueNotifier<String> selectedCharacter;

  const Character({Key? key, required this.selectedCharacter}) : super(key: key);

  @override
  _CharacterState createState() => _CharacterState();
}

class _CharacterState extends State<Character> {

  // Move this method outside of the initState
  void setSelectedCharacter(String character) {
    widget.selectedCharacter.value = character;
  }

  @override
  void initState() {
    super.initState();
    // Perform any other initialization here if needed
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return ValueListenableBuilder<String>(
          valueListenable: widget.selectedCharacter,
          builder: (context, selectedCharacter, _) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/${widget.selectedCharacter.value}'),

                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
