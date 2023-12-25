import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class enemyAnimation extends SpriteAnimationComponent
    with HasGameRef<TowerDefenseGame>{
  // enemyAnimation() : super(size: Vector2.all(64.0)); // size parametresini belirtin

  // @override
  // Future<void> onLoad() async {
  //   final image = await Flame.images.load('enemies/thief/attack.png'); // Düşman resminizin yolu
  //   final jsonData = await Flame.bundle.loadString('assets/images/enemies/thief/attack.json'); // JSON dosyanızın yolu
  //   final data = jsonDecode(jsonData);
  //   final animationData = SpriteAnimationData.sequenced(
  //     amount: data['frames'].length, // kare sayısı
  //     amountPerRow: 4,
  //     stepTime: 0.1, // her kare arasındaki süre, saniye cinsinden
  //     textureSize: Vector2(480, 270), // her karenin boyutu
  //   );
  //   final animation = SpriteAnimation.fromFrameData(image, animationData);
  //   this.animation = animation; // Animasyonu bileşene ata
  //   gameRef.add(this); // Bileşeni oyunun bileşenler listesine ekle
  // }


}