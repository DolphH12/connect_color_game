import 'dart:async';

import 'package:connect_colors_game/main.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'grid_game/grid.dart';

class LevelGame extends World {
  late TimerComponent timerComponent;
  late TextComponent timerText;
  late TextComponent winText;
  late Grid grid;

  @override
  Future<void> onLoad() async {
    add(
      TextComponent(
        text: 'Conecta los Colores',
        position: Vector2(MyGame.sceneSize.x / 2, 30),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    timerComponent = TimerComponent(
      period: double.infinity,
      repeat: true,
      onTick: updateTimer,
    );

    timerText = TextComponent(
      text: 'Tiempo: 0.0',
      position: Vector2(MyGame.sceneSize.x / 2, 60),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );

    winText = TextComponent(
      text: '',
      position: Vector2(MyGame.sceneSize.x / 2, MyGame.sceneSize.y / 2),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 22,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(timerComponent);
    add(timerText);
    add(winText);

    grid = Grid(onAllBlocksCleared: handleWin);

    add(grid);
  }

  void updateTimer() {
    timerText.text =
        'Tiempo: ${timerComponent.timer.current.toStringAsFixed(1)}';
  }

  void handleWin() {
    winText.text =
        '¡Ganaste!\nTardaste ${timerComponent.timer.current.toStringAsFixed(1)}';
    timerComponent.timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateTimer();
  }
}
