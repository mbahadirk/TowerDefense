import 'dart:async';
import 'dart:convert';
import 'Tower.dart';
import 'towerGroup.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense_game/screens/game/tower_defense_game.dart';

enum PlayerState {
  walk,
  attack,
  hurt,
  die,
}

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<TowerDefenseGame>, CollisionCallbacks {
  double speed = 30;
  var health = 100;
  var range = 10;
  var collidedWith = Component();
  late String charName;
  late ShapeHitbox hitbox;
  late String state;
  late var path;
  late String jsonData;
  late String stateString;
  late var data;
  late SpriteAnimationData animationData;
  @override
  late SpriteAnimation animation;
  bool isMoving = true;
  bool isAlive = true;

  bool collision = false;
  late TowerGroup towerGroup;
  double stepTime = 0.08;
  late Map<PlayerState, SpriteAnimation> _animations;
  PlayerState getStateFromString(String state) {
    switch (state) {
      case 'walk':
        return PlayerState.walk;
      case 'attack':
        return PlayerState.attack;
      case 'hurt':
        return PlayerState.hurt;
      case 'die':
        return PlayerState.die;
      default:
        throw ArgumentError('Invalid state: $state');
    }
  }

  Enemy(Vector2 position,
      Vector2 size,
      this.charName,
      this.towerGroup,) : super(position: position, size: size) {
    _animations = {};

  }


  Future<void> loadAnimations(TowerDefenseGame game) async {
    await _loadWalkAnimation(game);
    await _loadAttackAnimation(game);
    await _loadHurtAnimation(game);
    await _loadDieAnimation(game);

    hitbox = RectangleHitbox();
    add(hitbox);
  }


  Future<void> _loadWalkAnimation(TowerDefenseGame game) async {
    final walkAnimation = await _spriteAnimation(game, PlayerState.walk, 1);
    _animations[PlayerState.walk] = walkAnimation;
  }

  Future<void> _loadAttackAnimation(TowerDefenseGame game) async {
    final attackAnimation = await _spriteAnimation(game, PlayerState.attack, 1);
    _animations[PlayerState.attack] = attackAnimation;
  }

  Future<void> _loadHurtAnimation(TowerDefenseGame game) async {
    final hurtAnimation = await _spriteAnimation(game, PlayerState.hurt, 7);
    _animations[PlayerState.hurt] = hurtAnimation;
  }

  Future<void> _loadDieAnimation(TowerDefenseGame game) async {
    final dieAnimation = await _spriteAnimation(game, PlayerState.die, 12);
    _animations[PlayerState.die] = dieAnimation;
  }

  Future<SpriteAnimation> _spriteAnimation(TowerDefenseGame game, PlayerState state, int amount) async {
   stateString = getStateString(state);
    path = 'enemies/$charName/$stateString.png';
    jsonData = await Flame.bundle.loadString('assets/images/enemies/thief/walk.json'); // JSON dosyanızın yolu
    data = jsonDecode(jsonData);
    await game.images.load(path);
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  String getStateString(PlayerState state) {
    switch (state) {
      case PlayerState.walk:
        return 'walk';
      case PlayerState.attack:
        return 'attack';
      case PlayerState.hurt:
        return 'hurt';
      case PlayerState.die:
        return 'die';
    }
  }


  @override
  Future<void> onLoad() async {
    for (var state in ['walk', 'attack', 'hurt', 'die']) {
      path = await game.images.load('enemies/$charName/$state.png');
      jsonData = await Flame.bundle.loadString('assets/images/enemies/$charName/$state.json');
      //print('jsonData for $state: $jsonData'); // Add this line for debugging
      data = jsonDecode(jsonData);
      animationData = SpriteAnimationData.sequenced(
        amount: data['frames'].length, // kare sayısı
        amountPerRow: 4,
        stepTime: 0.08,   // her kare arasındaki süre, saniye cinsinden
        textureSize: Vector2(480, 270), // her karenin boyutu
      );
      animation = SpriteAnimation.fromFrameData(path, animationData);
      _animations[getStateFromString(state)] = animation;
    }

    await loadAnimations(game);
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints,
      PositionComponent other,) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Tower) {
      attackTower(other);
    }
  }

  void attackTower(Tower tower) {
    isMoving = false;
    tower.health -= 10;
    current = PlayerState.attack;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // gölge
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2);
    final shadowOffset = Offset(size.x / 2, size.y * 4 / 5);
    final shadowRadius = size.length / 15;
    canvas.drawCircle(shadowOffset, shadowRadius, shadowPaint);

    // can barları
    final paint = Paint()
      ..color = const Color(0xFF2DFF18); // Kırmızı renk
    final double healthBarWidth = width *
        (health / 500); // Can değerine göre genişlik
    const double healthBarHeight = 3.0; // Yükseklik
    final healthBarRect = Rect.fromLTWH(
        size.x / 2 - healthBarWidth / 2, 3, healthBarWidth,
        healthBarHeight); // Pozisyon ve boyut
    canvas.drawRect(healthBarRect, paint);
    // eklenmeden düşman çizilmiyor

  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isMoving) {
      position.x -= speed * dt;
      current = PlayerState.walk;
      state = 'walk';

    }

    if (health <= 0) {
      current = PlayerState.die;
    }

  }
}