import 'package:flutter/material.dart';
import 'package:flame/game.dart';

  TowerDefenseGame _towerDefenseGame = TowerDefenseGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return WillPopScope(
      onWillPop: () async => false,
      child: GameWidget(
      game : _towerDefenseGame(),
      ),
    );
  }
}