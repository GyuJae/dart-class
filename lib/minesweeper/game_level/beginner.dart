import 'package:dart_playground/minesweeper/game_level/game_level.dart';

class Beginner extends GameLevel {
  @override
  int getRowSize() {
    return 8;
  }

  @override
  int getColSize() {
    return 10;
  }

  @override
  int getLandMineCount() {
    return 10;
  }
}
