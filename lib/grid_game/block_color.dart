import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'grid.dart';

class BlockColor extends RectangleComponent with TapCallbacks {
  final Color color;

  BlockColor(this.color) : super(size: Vector2.all(50));

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = color;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    final grid = parent as Grid;
    grid.handleBlockTap(this);
  }
}
