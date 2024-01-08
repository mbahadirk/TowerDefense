import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:tower_defense_game/screens/Level/backgroundlevel.dart';
import 'package:tower_defense_game/screens/Level/sky.dart';
import 'package:tower_defense_game/screens/Level/sun.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';

class Level extends World with HasGameRef<TowerDefenseGame>{
  final String selectedBackground; // Assuming you have this property
  ValueNotifier<String> selectedBackgroundNotifier = ValueNotifier<String>('assets/characters/character_Autumn.jpg');
  ValueNotifier<String> selectedCharacterNotifier = ValueNotifier<String>('backGrounds/background_Default.jpg');


  Level({required this.selectedBackground});
  @override
  Future<void> onLoad() async {
    await gameRef.addAll([
      Background(selectedBackground: selectedBackground),
      Sun(),
      Sky(),
    ]);
    return super.onLoad();
  }
}