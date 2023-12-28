import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/components/Tower.dart';
import 'package:tower_defense/components/towerGroup.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

enum PlayerState{
  walk,
  attack,
  die,
  hurt,
}


class Enemy extends SpriteAnimationGroupComponent with HasGameRef<TowerDefenseGame>,CollisionCallbacks {
  double speed = 30;
  var health = 100;
  var range = 10;
  var collidedWith = Component();
  late String charName;
  late ShapeHitbox hitbox;
  late String state;
  bool isMoving = true;
  bool isAlive = true;
  bool debugMode = true;    //debug mode açar
  bool collision = false;
  TowerGroup towerGroup;
  double stepTime = 0.08;


  Enemy(
      Vector2 position,
      Vector2 size,
      String charName,
      this.towerGroup,  // TowerGroup nesnesini parametre olarak al
      ) : super(position: position, size:size){
    this.charName = charName;
    // this.state = "walk";  // Varsayılan durumu "walk" olarak ayarladım
  }


  SpriteAnimation _spriteAnimation(String state, int amount)  {
    var a = game.images.load('enemies/$charName/$state.png');
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('enemies/$charName/$state.png'),
      SpriteAnimationData.sequenced(
        amount: 18,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
  void _loadAllAnimations() {
    final dieAnimation = _spriteAnimation('die', 12);
    final attackAnimation = _spriteAnimation('attack', 1);
    final walkAnimation = _spriteAnimation('walk', 1);
    final hurtAnimation = _spriteAnimation('hurt', 7);

    // List of all animations
    animations = {
      PlayerState.walk: walkAnimation,
      PlayerState.attack: attackAnimation,
      PlayerState.hurt: hurtAnimation,
      PlayerState.die: dieAnimation,
    };

    // Set current animation
    current = PlayerState.walk;
  }


  @override
  FutureOr<void> onLoad() async {
    for (var state in ['walk', 'attack', 'hurt', 'die']) {
      await game.images.load('enemies/$charName/$state.png');
    }
    _loadAllAnimations();
    // final image = await Flame.images.load('enemies/$charName/$state.png'); // Düşman resminizin yolu
    // final jsonData = await Flame.bundle.loadString('assets/images/enemies/$charName/$state.json'); // JSON dosyanızın yolu
    // final data = jsonDecode(jsonData);
    // final animationData = SpriteAnimationData.sequenced(
    //   amount: data['frames'].length, // kare sayısı
    //   amountPerRow: 4,
    //   stepTime: 0.08,   // her kare arasındaki süre, saniye cinsinden
    //   textureSize: Vector2(480, 270), // her karenin boyutu
    // );
    // final animation = SpriteAnimation.fromFrameData(image, animationData);
    // this.animation = animation; // Animasyonu bileşene ata
    this.animations = animations ;
    hitbox = RectangleHitbox();
    add(hitbox);
    return super.onLoad();
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    print(collidedWith);

    // çarpıştığı objeye göre state ayarları burada if state'ler ile yapılır
    if (other is Tower) {
      attackTower(other);
    }
  }
  void attackTower(tower){
    isMoving = false;
    tower.health -= 50;
    current = PlayerState.attack;
    // TODO! add attack function here
  }


  @override
  void update(double dt) {
    super.update(dt);
    if (isMoving) {
      position.x -= speed * dt;    //düşman hareketi hıza bağlı
    }
    super.update(dt);
    // print(current.toString());
  }

}