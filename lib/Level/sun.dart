import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/tower_defense_game.dart';
import 'package:flame/parallax.dart';
import '../game/assets.dart';
import '../game/config.dart';

class Sun extends SpriteComponent
    with HasGameRef<TowerDefenseGame>{
  Sun();

  @override
  Future<void> onLoad() async{
    final sun = await Flame.images.load(Assets.sun);
    size = Vector2(150, 150);
    position = Vector2(320, 40);
    sprite = Sprite(sun);

  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}