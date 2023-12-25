import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyPainter extends SpriteAnimationComponent {
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.blue; // Kırmızı renk
    final healthBarRect = Rect.fromLTWH(175, 336 , 10, 10); // Pozisyon ve boyut
    canvas.drawRect(healthBarRect, paint);
  }

}