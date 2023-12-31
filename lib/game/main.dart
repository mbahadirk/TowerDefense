import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  @override
  final game = TowerDefenseGame();
  runApp(
      GameWidget(game:kDebugMode ? TowerDefenseGame() : game),
  );
}