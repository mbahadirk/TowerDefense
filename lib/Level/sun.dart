import 'dart:ui';
import 'package:flame/particles.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game/tower_defense_game.dart';
import '../game/assets.dart';

class Sun extends SpriteComponent
    with HasGameRef<TowerDefenseGame> {

  double scaleDirection = 0.5;
  late Particle particles;

  Sun();

  late SpriteComponent color;

  @override
  Future<void> onLoad() async {
    final sun = await Flame.images.load(Assets.sun);
    size = Vector2(150, 150);
    position = Vector2(700, 100);
    sprite = Sprite(sun);
    paint = Paint()
      ..color = Color(0x80FFFFFF); // Bu, güneşi yarı saydam yapar.
    anchor = Anchor.center;

    // particles = Particle.generate(
    //     count: 1000,
    //     lifespan: 5,  // particle'ların ne kadar süre hayatta kalacağı
    //     generator: (i) => AcceleratedParticle(
    //       position: Vector2.all(0),
    //       speed: Vector2.random() * 100,
    //       acceleration: Vector2.random() * 100,
    //       lifespan: 2.0,
    //       child: CircleParticle(
    //         radius: 10.0,
    //         paint: Paint()..color = Color(0xFFFFA500),
    //       ),
    //     ));
  }

  // Gölgeyi çiz

  @override
  void update(double dt) {
    super.update(dt);
    angle += 0.005; // Her çerçeve güncellendiğinde güneşi biraz döndürür.

    // Güneşi büyütür veya küçültür
    size += Vector2.all(scaleDirection);
    if (size.x > 150 || size.x < 125) {
      scaleDirection = -scaleDirection;
    }
    // particles.update(dt);

  }
}