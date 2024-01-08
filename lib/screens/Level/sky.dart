import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';
import 'package:flame/parallax.dart';
import 'package:tower_defense_game/screens/game/assets.dart';
import 'package:tower_defense_game/screens/game/config.dart';

class Sky extends ParallaxComponent<TowerDefenseGame>
    with HasGameRef<TowerDefenseGame>{
  Sky();

  @override
  Future<void> onLoad() async{
    final cloud = await Flame.images.load(Assets.clouds2);
    final resizedCloud = await cloud.resize(Vector2(600, 200));
    position = Vector2(x,-Config.cloudHeight);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(
          resizedCloud,
          fill: LayerFill.none,

        ),

      ),
    ]);

  }
  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.cloudSpeed;
  }
}