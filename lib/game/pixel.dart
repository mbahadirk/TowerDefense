import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tower_defense/Level/level.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

class Pixel extends FlameGame{
  @override
  Color backgroundColor() =>const Color(0xFF211F30);
  late final CameraComponent cam;

  @override
  FutureOr<void>onLoad() async{
    //butun fotograflari yukle..cache
    await images.loadAllImages();

    cam=CameraComponent.withFixedResolution(world:world,width : 640, height:360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam,world]);
    return super.onLoad();
  }
}
