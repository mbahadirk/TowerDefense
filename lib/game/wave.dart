import 'dart:math';
import 'package:flame/components.dart';
import 'package:tower_defense/components/towerGroup.dart';
import 'package:tower_defense/game/tower_defense_game.dart';
import 'package:flame/components.dart';

import '../components/enemy.dart';

class Wave extends Component with HasGameRef<TowerDefenseGame> {
  final int enemyCount;
  int enemiesSpawned = 0;

  Wave(this.enemyCount);

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < 10; i++) {
      spawnEnemy();
    }
  }

  void spawnEnemy() {
    final random = Random();
    final sY = 200;
    final roads = [
      [sY+5, sY+25],
      [sY+60, sY+75],
      [sY+105, sY+130],
    ];
    final range = roads[random.nextInt(roads.length)];
    final xCoord = 500 + random.nextDouble() * (1000 - 300);
    final yCoord = range[0] + random.nextDouble() * (range[1] - range[0]);

    final characters = ["archer", "knight", "merchant", "priest", "soldier", "thief"];
    final charName = characters[random.nextInt(characters.length)];

    final enemy = Enemy(
      Vector2(xCoord, yCoord),
      Vector2(70, 40),
      "thief",
      TowerGroup()
    );
    gameRef.add(enemy);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}