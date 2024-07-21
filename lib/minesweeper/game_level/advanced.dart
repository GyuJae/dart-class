import 'package:dart_playground/minesweeper/game_level/game_level.dart';

class Advanced extends GameLevel {
  @override
  int getRowSize() {
    return 20;
  }

  @override
  int getColSize() {
    return 24;
  }

  @override
  int getLandMineCount() {
    return 99;
  }
}
