import 'package:dart_playground/minesweeper/game_level/game_level.dart';

class Middle extends GameLevel {
  @override
  int getRowSize() {
    return 14;
  }

  @override
  int getColSize() {
    return 18;
  }

  @override
  int getLandMineCount() {
    return 40;
  }
}
