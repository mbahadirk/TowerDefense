import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:tower_defense/Level/background.dart';
import 'package:tower_defense/Level/sky.dart';
import 'package:tower_defense/Level/sun.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class Level extends World with HasGameRef<TowerDefenseGame>{
  @override
  Future<void> onLoad() async {
    await gameRef.addAll([
      Background(),
      Sun(),
      Sky(),
    ]);
    return super.onLoad();
  }
}