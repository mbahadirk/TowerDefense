import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/Level/background.dart';
import 'package:tower_defense/Level/sky.dart';
import 'package:tower_defense/Level/sun.dart';
import 'package:tower_defense/components/tower1.dart';
import 'package:tower_defense/components/tower2.dart';
import 'package:tower_defense/components/tower3.dart';

import '../components/Castle.dart';

class TowerDefenseGame extends FlameGame{
  @override
  Future<void> onLoad() async{
    addAll([
      Background(),
      Sun(),
      Sky(),
      Tower1(),
      Tower2(),
      Tower3(),
      Castle(),
    ]);

  }

}