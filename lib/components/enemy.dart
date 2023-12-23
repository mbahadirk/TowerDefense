import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/roads.dart';
import 'package:tower_defense/game/tower_defense_game.dart';

import 'Tower.dart';


class Enemy extends PositionComponent with HasGameRef<TowerDefenseGame>{
  var health = 100;
  late double speed;
  late double width;
  late double heigth;
  bool isMoving = true;
  late Tower selectedTower;
  var range = 10;

  Enemy(
      Vector2 position,
      this.width,
      this.heigth,
      double speed,
      ) : super(position: position)
  {this.speed = speed;}

  // @override
  // Future<void> onLoad() async {
  //   final image = await Flame.images.load('enemies/thief/walk.png'); // Düşman resminizin yolu
  //   final jsonData = await Flame.bundle.loadString('assets/images/enemies/thief/walk.json'); // JSON dosyanızın yolu
  //   final data = jsonDecode(jsonData);
  //   final animation = SpriteAnimation.fromAsepriteData(image, data);
  //   this.animation = animation;
  // }


  @override
  void render(Canvas canvas) {
    super.render(canvas); // Bu, animasyonu çizer

    // Ekstra çizimlerinizi burada yapabilirsiniz
    final paint = Paint()..color = Color(0xFFFF0000); // Kırmızı renk
    final enemyRect = Rect.fromLTWH(0, 200 , this.width, this.heigth); // Pozisyon ve boyut
    canvas.drawRect(enemyRect, paint);
  }
  void checkCollision(){
    // if (position.y in )
    if (position.x <= 175 + range) {
      isMoving = false;
    }
  }

  // void towerSelection(){
  //   if (Roads.road1.contains(position.y)){
  //     selectedTower = Tower();
  //   }
  // }

  @override
  void update(double dt) {
    super.update(dt);

    checkCollision();

    if (isMoving) {
      position.x -= speed * dt;    //düşman hareketi hıza bağlı
    }
  }
}