import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class Background extends SpriteComponent with HasGameRef<TowerDefenseGame>{
  Background();

  @override
  Future<void> onLoad() async{
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}