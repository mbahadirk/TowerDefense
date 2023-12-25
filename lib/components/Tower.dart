import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/assets.dart';

class Tower extends PositionComponent{
  var health = 100;
  bool alive = true;
  String type;
  late Sprite sprite;   // henüz tanımlanmamış ifade olan sprite'a late ile
                        // sonradan tanımlanacağını belirttik

  Tower(
      Vector2 position,
      Vector2 size,
      this.type
      ) : super(position: position,size:size);
  @override
  bool debugMode = true;    // debug mod açar

  @override
  Future<void> onLoad() async{
    final towerImage = await Flame.images.load(Assets.getAsset(this.type));
    sprite = Sprite(towerImage);
    size = size;
  }

  @override
  void render(Canvas canvas) {
    if (alive == true){       // hayatta olan kule çizilir
    sprite.render(canvas, position: position, size: size);
    }

    final paint = Paint()..color = Color(0xFFFF0000); // Kırmızı renk
    final double healthBarWidth = width * (health / 100); // Can değerine göre genişlik
    final double healthBarHeight = 3; // Yükseklik
    final healthBarRect = Rect.fromLTWH(position.x, position.y - 10, healthBarWidth, healthBarHeight); // Pozisyon ve boyut
    canvas.drawRect(healthBarRect, paint);
  }

  void update(double dt){
    super.update(dt);
  }
}