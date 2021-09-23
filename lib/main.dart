import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import "dart:math";

/*
To-do:

Check out on window resize function to recalibrate size


*/

void main() {
  final myGame = MyGame();
  runApp(
    GameWidget(game: myGame),
  );
}

class MyGame extends BaseGame with HasTappableComponents {
  Player player = Player();
  // late double screenHight;
  // late double screenWidth;
  var rng = Random();

  @override
  Future<void> onLoad() async {
    // screenWidth = size[0];
    // screenHight = size[1];
    player.loadPlayer();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.move(rng, size);
  }
}

enum Directions {
  up,
  down,
  left,
  right,
}

class Player extends SpriteComponent with Tappable {
  bool isMovingDown = true;
  double speed = 3;
  Directions direction = Directions.left;

  void loadPlayer() async {
    sprite = await Sprite.load('explosion-0.png');
    position = Vector2(200, 200);
    size = Vector2(200, 200);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    try {
      isMovingDown = !isMovingDown;
      speed += 0.4;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void newRandomDirection(Random rng) {
    //add axis argument to check direction and move player back to last position
    var prevX = x;
    var prevY = y;
    var randomNumber = rng.nextInt(Directions.values.length);
    var randomDirection = Directions.values[randomNumber];
    direction = randomDirection;
    y = prevY;
    x = prevX;
  }

  void move(Random rng, Vector2 windowSize) {
    if (y + (size.y / 2) >= windowSize.y ||
        y + size.y <= 0 ||
        x <= 0 ||
        x + size.x >= windowSize.x) {
      newRandomDirection(rng);
      //dem finner ny direction i motsatt akse fordi den er ikke enda
    }

    if (direction == Directions.down) {
      y += speed;
    }
    if (direction == Directions.up) {
      y -= speed;
    }
    if (direction == Directions.right) {
      x += speed;
    }
    if (direction == Directions.left) {
      x -= speed;
    }
  }

  // if (isMovingDown) {
  //   y += speed;
  // } else
  //   y -= speed;

  // if (y > 400) isMovingDown = !isMovingDown;
  // if (y < 10) isMovingDown = !isMovingDown;
}

//void changeDirection()

// class MyGame extends Game {
//   late Sprite player;
//   @override
//   Future<void> onLoad() async {
//     player = await Sprite.load('crate.png');
//   }

//   @override
//   void update(double dt) {

//   }

//   @override
//   void render(Canvas canvas) {
//     player.render(canvas);
//   }
// }

// class Player extends SpriteComponent {
//   late Sprite player;

//   Player() {
//     LoadPlayer();
//   }

//   void LoadPlayer() async {
//     player = await Sprite.load('crate.png');
//   }
// }

// class MyGame extends BaseGame {
//   late final SpriteComponent player;

//   @override
//   Future<void> onLoad() async {
//     Image image = await images.load('player.png');

// final sprite = Sprite(image);
//     final size = Vector2.all(128.0);
//     final player = SpriteComponent(size: size, sprite: sprite);

//     // screen coordinates
//     player.position = Vector2(0.0, 0.0);
//     player.angle = 0;
//     add(player);
//   }
// }

// void main() {
//   final myGame = MyGame();
//   runApp(
//     GameWidget(game: myGame),
//   );
// }

// class MyGame extends Game {
//   static const int squareSpeed = 10;
//   static final squarePaint = BasicPalette.white.paint();
//   late Rect squarePos;
//   int squareDirection = 1;

//   final imagesLoader = Images();

//   Future<void> onLoad() async {
//     squarePos = const Rect.fromLTWH(0, 0, 100, 100);

//     final sprite = await Sprite.load('player.png');
//     final size = Vector2.all(128.0);
//     final player = SpriteComponent(size: size, sprite: sprite);

//     add(player);
//   }

//   @override
//   void update(double dt) {
//     squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

//     if (squareDirection == 1 && squarePos.right > size.x) {
//       squareDirection = -1;
//     } else if (squareDirection == -1 && squarePos.left < 0) {
//       squareDirection = 1;
//     }
//   }

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(squarePos, squarePaint);
//   }
// }
