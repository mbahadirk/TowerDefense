
class Assets {
  static const background = 'components/background_Grass.png';

  static const sideTower = 'components/tower.png';
  static const castle = 'components/castle.png';

  static const clouds = 'components/clouds.png';
  static const clouds2 = 'components/clouds2.png';
  static const sun = 'components/sun.png';

  static String getAsset(String imageName){
    var image = "components/$imageName.png";
    return image;
  }

}
