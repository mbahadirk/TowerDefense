import 'dart:convert';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Enemy extends SpriteAnimationComponent {
  var health = 100;

  Enemy(
      Vector2 position,
      double width,
      double height) : super(position: position, size: Vector2(width, height));

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('enemies/thief/walk.png'); // Düşman resminizin yolu
    final jsonData = await Flame.bundle.loadString('assets/images/enemies/thief/walk.json'); // JSON dosyanızın yolu
    final data = jsonDecode(jsonData);
    final animation = SpriteAnimation.fromAsepriteData(image, data);
    this.animation = animation;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas); // Bu, animasyonu çizer

    // Ekstra çizimlerinizi burada yapabilirsiniz
  }
  @override
  void update(double dt) {
    super.update(dt);
  }
}