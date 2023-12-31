
class Assets {
  static const background = 'components/background.png';
  static const sideTower = 'components/tower.png';
  static const castle = 'components/castle.png';
  static const clouds = 'components/clouds.png';
  static const clouds2 = 'components/clouds2.png';
  static const sun = 'components/sun.png';

  static String getEnemyAsset(String enemyName, String action) {
    return "enemies/$enemyName/$action.png";
  }
}
final dieAsset = Assets.getEnemyAsset('thief', 'die');



