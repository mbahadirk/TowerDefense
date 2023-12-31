import 'dart:math';
import 'package:flame/components.dart';
import 'package:tower_defense_game/screens/components/enemy.dart';
import 'package:tower_defense_game/screens/components/towerGroup.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';

class Wave extends Component with HasGameRef<TowerDefenseGame> {
  final int enemyCount;
  int enemiesSpawned = 0;

  Wave(this.enemyCount);

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < enemyCount; i++) {
      await spawnEnemy();
    }
  }

  Future<void> spawnEnemy()  async {
    final random = Random();
    final sY = 200;
    final roads = [
      [sY + 5, sY + 25],
      [sY + 60, sY + 75],
      [sY + 105, sY + 130],
    ];
    final range = roads[random.nextInt(roads.length)];
    final xCoord = 500 + random.nextDouble() * (1000 - 300);
    final yCoord = range[0] + random.nextDouble() * (range[1] - range[0]);

    final characters = ["thief"];
    final charName = characters[random.nextInt(characters.length)];

    final enemy = Enemy(
      Vector2(xCoord, yCoord),
      Vector2(70, 40),
      charName,
      TowerGroup(),
    );
    gameRef.add(enemy);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
