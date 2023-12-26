import 'dart:convert';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/components/towerGroup.dart';
import 'package:tower_defense/game/tower_defense_game.dart';


class Enemy extends SpriteAnimationComponent with HasGameRef<TowerDefenseGame>, CollisionCallbacks {
  var health = 100;
  double speed = 30;
  bool isMoving = true;
  var range = 10;
  late String charName;
  late String state;
  bool isAlive = true;

  TowerGroup towerGroup;  // TowerGroup nesnesi

  Enemy(
      Vector2 position,
      Vector2 size,
      String charName,
      this.towerGroup,  // TowerGroup nesnesini parametre olarak al
      ) : super(position: position, size:size){
    this.charName = charName;
    this.state = "walk";  // Varsayılan durumu "walk" olarak ayarladım
  }

  bool debugMode = true;    //debug mode açar
  late ShapeHitbox hitbox;
  bool collision = false;

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('enemies/$charName/$state.png'); // Düşman resminizin yolu
    final jsonData = await Flame.bundle.loadString('assets/images/enemies/$charName/$state.json'); // JSON dosyanızın yolu
    final data = jsonDecode(jsonData);
    final animationData = SpriteAnimationData.sequenced(
      amount: data['frames'].length, // kare sayısı
      amountPerRow: 4,
      stepTime: 0.08,   // her kare arasındaki süre, saniye cinsinden
      textureSize: Vector2(480, 270), // her karenin boyutu
    );
    final animation = SpriteAnimation.fromFrameData(image, animationData);
    this.animation = animation; // Animasyonu bileşene ata

    hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollision(intersectionPoints, other);
    for (var tower in towerGroup.towers) {
      // print("for works ${tower}");
      if (tower == other){
        print("allah çarpsın works");
      }

    }
  }


  @override
  void render(Canvas canvas) {
    // gölge
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2);
    final shadowOffset = Offset(size.x/2, size.y*4/5);
    final shadowRadius = size.length /15;
    canvas.drawCircle(shadowOffset, shadowRadius, shadowPaint);

    // can barları
    final paint = Paint()..color = Color(0xFF2DFF18); // Kırmızı renk
    final double healthBarWidth = width * (health / 500); // Can değerine göre genişlik
    const double healthBarHeight = 3.0; // Yükseklik
    final healthBarRect = Rect.fromLTWH(size.x/2-healthBarWidth/2, 3, healthBarWidth, healthBarHeight); // Pozisyon ve boyut
    canvas.drawRect(healthBarRect, paint);


    // eklenmeden düşman çizilmiyor
    super.render(canvas);
  }



  @override
  void update(double dt) {
    super.update(dt);

    if (isMoving) {
      position.x -= speed * dt;    //düşman hareketi hıza bağlı
    }

    onCollisionCallback;
  }
}