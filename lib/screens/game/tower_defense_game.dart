import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tower_defense_game/screens/Level/level.dart';
import 'package:tower_defense_game/screens/components/towerGroup.dart';
import 'package:tower_defense_game/screens/game/wave.dart';
import 'package:tower_defense_game/screens/tools(will%20be%20deleted)/pointer.dart';




class TowerDefenseGame extends FlameGame with HasCollisionDetection {
  late final CameraComponent cam;

  static get selectedBackground => null;

  @override
  Color backgroundColor() => const Color(0xFF87E127);

  @override
  final world = Level(selectedBackground: "assets/$selectedBackground");


  @override
  Future<void> onLoad() async {
    cam = CameraComponent.withFixedResolution(
      world: Level(selectedBackground: 'assets/$selectedBackground'),
      width: 1920,
      height: 1080,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      world,
      MyPainter(),
      Wave(10),
      TowerGroup(),
    ]);
  }
}
