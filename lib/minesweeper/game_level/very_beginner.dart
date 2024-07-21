import 'package:dart_playground/minesweeper/game_level/game_level.dart';

class VeryBeginner extends GameLevel {
  @override
  int getRowSize() {
    return 4;
  }

  @override
  int getColSize() {
    return 5;
  }

  @override
  int getLandMineCount() {
    return 4;
  }
}
