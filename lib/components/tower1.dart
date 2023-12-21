import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';

class Tower1 extends SpriteComponent{
  Tower1();

  var health = 100;


  @override
  Future<void> onLoad() async{
    final tower1 = await Flame.images.load(Assets.sideTower);
    size = Vector2(50, 75);
    position = Vector2(125, 170);
    sprite = Sprite(tower1);
  }

  void update(double dt){
    super.update(dt);
  }
}