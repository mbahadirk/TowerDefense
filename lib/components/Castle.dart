import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';

class Castle extends SpriteComponent{
  Castle();

  var health = 100;


  @override
  Future<void> onLoad() async{
    final castle = await Flame.images.load(Assets.castle);
    size = Vector2(300, 300);
    position = Vector2(-90, 80);
    sprite = Sprite(castle);
  }

  void update(double dt){
    super.update(dt);
  }
}