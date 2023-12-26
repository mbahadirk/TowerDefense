import 'package:flame/components.dart';
import 'package:tower_defense/components/Tower.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class TowerGroup extends World with HasGameRef<TowerDefenseGame> {
  final topTower = Tower(
    Vector2(130, 180),
    Vector2(50, 75),
    "tower",
  );
  final midTower = Tower(
    Vector2(190, 230),
    Vector2(50, 75),
    "tower",
  );
  final bottomTower = Tower(
    Vector2(130, 280),
    Vector2(50, 75),
    "tower",
  );
  final castle = Tower(
    Vector2(-40, 80),
    Vector2(150, 300),
    "castle",
  );
  @override
  Future<void> onLoad() async {
    await gameRef.addAll([
      topTower,
      midTower,
      bottomTower,
      castle,
    ]);
  }

  List<Tower> get towers => [topTower, midTower, bottomTower, castle];

}