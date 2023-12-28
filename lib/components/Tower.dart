import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game/assets.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class Tower extends SpriteComponent with HasGameRef<TowerDefenseGame>, CollisionCallbacks{
  var health = 100;
  bool alive = true;
  String type;

  Tower(
      Vector2 position,
      Vector2 size,
      this.type
      ) : super(position: position,size:size);
  //bool debugMode = true;    // debug mod açar
  late ShapeHitbox hitbox;
  final _collisionStartColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  // bool carpisma = false;


  @override
  Future<void> onLoad() async{
    final tower = await Flame.images.load("components/$type.png");
    position = position;
    size = size;
    sprite = Sprite(tower);
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }


  @override
  void update(double dt){
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // can barı
    final paint = Paint()..color = Color(0xFFFF0000); // Kırmızı renk
    final double healthBarWidth = width * (health / 100); // Can değerine göre genişlik
    final double healthBarHeight = 3; // Yükseklik
    final healthBarRect = Rect.fromLTWH(0, -10, healthBarWidth, healthBarHeight); // Pozisyon ve boyut
    canvas.drawRect(healthBarRect, paint);

    // gölge
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2);
    final shadowOffset = Offset(size.x/3, size.y);
    final shadowRadius = size.length/5 ;
    canvas.drawCircle(shadowOffset, shadowRadius, shadowPaint);

    super.render(canvas);
  }
}