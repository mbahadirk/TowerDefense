import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tower_defense/Level/background.dart';
import 'package:tower_defense/Level/sky.dart';
import 'package:tower_defense/Level/sun.dart';
import 'package:tower_defense/components/enemy.dart';
import 'package:tower_defense/tools(will%20be%20deleted)/pointer.dart';
import '../components/Tower.dart';

class TowerDefenseGame extends FlameGame{
  @override
  Future<void> onLoad() async{
    final topTower = Tower(
      Vector2(65,85),
      50,
      75,
      "tower",
    );
    final midTower = Tower(
      Vector2(95,110),
      50,
      75,
      "tower",
    );
    final bottomTower = Tower(
      Vector2(65,130),
      50,
      75,
      "tower",
    );
    final castle = Tower(
      Vector2(-50,40),
      300,
      300,
      "castle",
    );
    final thief = Enemy(
        Vector2(850, 0),
        20,   //width
        40,  //height
        80
    );
    addAll([
      Background(),
      Sun(),
      Sky(),
      castle,
      topTower,
      midTower,
      bottomTower,
      thief,
      MyPainter()
    ]);

  }

}