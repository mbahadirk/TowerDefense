import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:tower_defense_game/screens/game/assets.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Background extends SpriteComponent with HasGameRef<TowerDefenseGame> {
  late final String selectedBackground;

  Background({required this.selectedBackground});


  //Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.backgroundassets);
    size = gameRef.size;
    sprite = Sprite(background);
  }

  void setSelectedBackground(String background) {
    selectedBackground = background;
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$selectedBackground'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}