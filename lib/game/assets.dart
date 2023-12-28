
class Assets {
  static const background = 'components/background.png';

  static const sideTower = 'components/tower.png';
  static const castle = 'components/castle.png';

  static const clouds = 'components/clouds.png';
  static const clouds2 = 'components/clouds2.png';
  static const sun = 'components/sun.png';

  static const die = "enemies/thief/die.png";
  static const walk = "enemies/thief/walk.png";
  static const attack = "enemies/thief/attack.png";
  static const hurt = "enemies/thief/hurt.png";

  static String getAsset(String imageName){
    var image = "components/$imageName.png";
    return image;
  }

}
