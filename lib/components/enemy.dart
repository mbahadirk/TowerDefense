import 'dart:convert';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/roads.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

import 'Tower.dart';


class Enemy extends SpriteAnimationComponent with HasGameRef<TowerDefenseGame> {
  var health = 100;
  double speed = 18;
  bool isMoving = true;
  late Tower selectedTower;
  var range = 10;
  late String charName;
  late String state;
  Enemy(
      Vector2 position,
      Vector2 size,
      String charName,
      ) : super(position: position, size:size){charName;}

  bool debugMode = true;    //debug mode açar

  @override
  Future<void> onLoad() async {
    state = "walk";
    charName = "soldier";
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
  }


  @override
  void update(double dt) {
    super.update(dt);

    if (isMoving) {
      position.x -= speed * dt;    //düşman hareketi hıza bağlı
    }
  }
}