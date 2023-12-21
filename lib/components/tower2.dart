import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';

class Tower2 extends SpriteComponent{
  Tower2();

  var health = 100;

  @override
  Future<void> onLoad() async{
    final tower2 = await Flame.images.load(Assets.midTower);
    size = Vector2(50, 90);
    position = Vector2(200, 200);
    sprite = Sprite(tower2);
  }

  @override
  void update(double dt){
    super.update(dt);
  }
}