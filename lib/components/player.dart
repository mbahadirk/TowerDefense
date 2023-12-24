import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';
import 'package:tower_defense/game/pixel.dart';
import 'package:flame/sprite.dart';


enum PlayerState{ idle,running}


class Player extends SpriteAnimationGroupComponent
    width HasGameRef<TowerDefenseGame>{
  late final SpriteAnimation idleAnimation;
  final double stepTime=0.05;

  @override
  Future<void> onLoad() async {
    // Örnek bir animasyon yükleyelim
    final spriteSheet = await SpriteSheet.fromColumnsAndRows(
      image: await Flame.images.load('attack.png'),
      columns: 4,
      rows: 4,
    );

    return super.onLoad();
  }

  void loadAllAnimations(){
    idleAnimation=SpriteAnimation.fromFrameData(
      FlameGame.images.fromCache('images/attack.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime:stepTime,
        textureSize:Vector2.all(32)
      ),
    );

    //list of all animations
    animations={PlayerState.idle:idleAnimation};

    //current animation
    current = PlayerState.idle;
  }
}