import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tower_defense/Level/background.dart';
import 'package:tower_defense/Level/level.dart';
import 'package:tower_defense/Level/sky.dart';
import 'package:tower_defense/Level/sun.dart';
import 'package:tower_defense/components/enemy.dart';
import 'package:tower_defense/tools(will%20be%20deleted)/pointer.dart';
import '../components/Tower.dart';
import '../components/enemyAnimation.dart';

class TowerDefenseGame extends FlameGame{
  late final CameraComponent cam;
  Color backgroundColor() => const Color(0xFF87E127);

  @override
  final world = Level();

  @override
  Future<void> onLoad() async{

    cam = CameraComponent.withFixedResolution(world: Level(),width: 1920, height: 1080);
    cam.viewfinder.anchor = Anchor.topLeft;

    final topTower = Tower(
      Vector2(130,180),
      Vector2(50,75),
      "tower",
    );
    final midTower = Tower(
      Vector2(190,230),
      Vector2(50,75),
      "tower",
    );
    final bottomTower = Tower(
      Vector2(130,280),
      Vector2(50,75),
      "tower",
    );
    final castle = Tower(
      Vector2(-40,80),
      Vector2(150,300),
      "castle",
    );
    final thief = Enemy(
      Vector2(500, 200),
      Vector2(50,50),
      "thief"
    );
    final enemy1 = Enemy(
        Vector2(500, 200),
        Vector2(50,50),
        "thief"
    );
    addAll([
      cam,
      world,
      castle,
      topTower,
      midTower,
      bottomTower,
      thief,
      enemy1,
      MyPainter(),
    ]);
    final enemy = enemyAnimation();
    await add(enemy); // enemy bileşenini yükle ve ekle

  }

}