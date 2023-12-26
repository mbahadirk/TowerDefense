import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tower_defense/Level/level.dart';
import 'package:tower_defense/components/towerGroup.dart';
import 'package:tower_defense/game/wave.dart';
import 'package:tower_defense/tools(will%20be%20deleted)/pointer.dart';
import '../components/Tower.dart';
import '../components/enemy.dart';

class TowerDefenseGame extends FlameGame with HasCollisionDetection{
  late final CameraComponent cam;

  @override
  Color backgroundColor() => const Color(0xFF87E127);

  @override
  final world = Level();


  @override
  Future<void> onLoad() async{

    cam = CameraComponent.withFixedResolution(world: Level(),width: 1920, height: 1080);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      world,
      MyPainter(),
      Wave(10),
      TowerGroup()
    ]);

  }

}