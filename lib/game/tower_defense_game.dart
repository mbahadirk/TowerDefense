import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tower_defense/Level/level.dart';
import 'package:tower_defense/game/wave.dart';
import 'package:tower_defense/tools(will%20be%20deleted)/pointer.dart';
import '../components/Tower.dart';
import '../components/enemy.dart';

class TowerDefenseGame extends FlameGame{
  late final CameraComponent cam;

  @override
  Color backgroundColor() => const Color(0xFF87E127);

  @override
  final world = Level();


  @override
  Future<void> onLoad() async{

    cam = CameraComponent.withFixedResolution(world: Level(),width: 1920, height: 1080);
    cam.viewfinder.anchor = Anchor.topLeft;

    final wave = Wave(5);


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
    addAll([
      cam,
      world,
      castle,
      topTower,
      midTower,
      bottomTower,
      MyPainter(),
      Wave(10),
    ]);

  }

}