import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';

import 'block_color.dart';

class Grid extends Component {
  static const int rows = 6;
  static const int cols = 6;
  static const double cellSize = 50;
  static const double padding = 30;
  static const double margin = 5;

  Grid({required this.onAllBlocksCleared});

  final Function onAllBlocksCleared;

  BlockColor? firstSelectedBlock;

  final List<List<BlockColor?>> grid = List.generate(
    rows,
    (_) => List.filled(cols, null),
  );

  @override
  Future<void> onLoad() async {
    final colors = generatePairs(rows * cols ~/ 2);

    int colorIndex = 0;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final block = BlockColor(colors[colorIndex++]);
        grid[row][col] = block;

        final x = col * (cellSize + margin) + padding;
        final y = row * (cellSize + margin) + padding + 100;

        block.position = Vector2(x, y);
        block.anchor = Anchor.center;

        add(block);
      }
    }
  }

  List<Color> generatePairs(int pairsCount) {
    final List<Color> baseColors = [
      BasicPalette.red.color,
      BasicPalette.blue.color,
      BasicPalette.green.color,
      BasicPalette.yellow.color,
      BasicPalette.purple.color,
      BasicPalette.cyan.color,
    ];

    final List<Color> pairs = [];
    final random = Random();

    for (var i = 0; i < pairsCount; i++) {
      final Color color = baseColors[random.nextInt(baseColors.length)];
      pairs.add(color);
      pairs.add(color);
    }

    pairs.shuffle();
    return pairs;
  }

  void handleBlockTap(BlockColor block) {
    if (firstSelectedBlock == null) {
      firstSelectedBlock = block;
    } else {
      if (firstSelectedBlock!.color == block.color) {
        removeBlockWithAnimation(firstSelectedBlock!);
        removeBlockWithAnimation(block);
        checkWinCondition();
      }
      firstSelectedBlock = null;
    }
  }

  void removeBlockWithAnimation(BlockColor block) {
    block.add(ScaleEffect.to(
      Vector2.zero(),
      EffectController(duration: 0.3),
      onComplete: () => block.removeFromParent(),
    ));
  }

  void checkWinCondition() {
    if (children.length == 2) {
      onAllBlocksCleared();
    }
  }
}
