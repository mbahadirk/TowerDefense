import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';

class Tower3 extends SpriteComponent{
  Tower3();

  var health = 100;


  @override
  Future<void> onLoad() async{
    final tower3 = await Flame.images.load(Assets.sideTower);
    size = Vector2(50, 75);
    position = Vector2(125, 260);
    sprite = Sprite(tower3);
  }

  @override
  void update(double dt){
    super.update(dt);
  }

}