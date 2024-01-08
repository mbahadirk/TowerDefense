class Assets {
  static const sideTower = 'components/tower.png';
  static const castle = 'components/castle.png';
  static const clouds = 'components/clouds.png';
  static const clouds2 = 'components/clouds2.png';
  static const sun = 'components/sun.png';

  static String getEnemyAsset(String enemyName, String action) {
    return "enemies/$enemyName/$action.png";
  }

  static String get backgroundassets => 'components/background.png';
}

final dieAsset = Assets.getEnemyAsset('thief', 'die');
final walkAsset = Assets.getEnemyAsset('thief', 'walk');
final hurtAsset = Assets.getEnemyAsset('thief', 'hurt');
final attackAsset = Assets.getEnemyAsset('thief', 'attack');
final backgroundAsset = Assets.backgroundassets;
