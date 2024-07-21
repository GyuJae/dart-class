import 'dart:math';

import 'package:dart_playground/minesweeper/cell.dart';
import 'package:dart_playground/minesweeper/game_level/game_level.dart';

typedef CellBoard = List<List<Cell>>;

class Board {
  final GameLevel _level;
  final CellBoard _cellBoard;

  Board({
    required GameLevel level,
    required List<List<Cell>> cellBoard,
  })  : _level = level,
        _cellBoard = cellBoard;

  factory Board.fromLevel({
    required GameLevel level,
  }) {
    CellBoard cellBoard = List.generate(
      level.getRowSize(),
      (_) => List.generate(
        level.getColSize(),
        (_) => Cell.createClosed(),
      ),
    );

    Random random = Random();
    for (int i = 0; i < level.getLandMineCount(); i++) {
      int row = random.nextInt(level.getRowSize());
      int col = random.nextInt(level.getColSize());
      cellBoard[row][col] = cellBoard[row][col].updateLandMine();
    }

    for (int row = 0; row < level.getRowSize(); row++) {
      for (int col = 0; col < level.getColSize(); col++) {
        int count = 0;
        if (!cellBoard[row][col].isLandMine()) {
          if (row - 1 >= 0 &&
              col - 1 >= 0 &&
              cellBoard[row - 1][col - 1].isLandMine()) {
            count++;
          }
          if (row - 1 >= 0 && cellBoard[row - 1][col].isLandMine()) count++;
          if (row - 1 >= 0 &&
              col + 1 < level.getColSize() &&
              cellBoard[row - 1][col + 1].isLandMine()) {
            count++;
          }
          if (col - 1 >= 0 && cellBoard[row][col - 1].isLandMine()) count++;
          if (col + 1 < level.getColSize() &&
              cellBoard[row][col + 1].isLandMine()) {
            count++;
          }
          if (row + 1 < level.getRowSize() &&
              col - 1 >= 0 &&
              cellBoard[row + 1][col - 1].isLandMine()) {
            count++;
          }
          if (row + 1 < level.getRowSize() &&
              cellBoard[row + 1][col].isLandMine()) {
            count++;
          }
          if (row + 1 < level.getRowSize() &&
              col + 1 < level.getColSize() &&
              cellBoard[row + 1][col + 1].isLandMine()) {
            count++;
          }
          cellBoard[row][col] =
              cellBoard[row][col].updateNearByLandMineCount(count);
        }
      }
    }

    return Board(
      level: level,
      cellBoard: cellBoard,
    );
  }

  int getRowSize() {
    return _level.getRowSize();
  }

  int getColSize() {
    return _level.getColSize();
  }

  int getLandMineCount() {
    return _level.getLandMineCount();
  }

  Board flag(int row, int col) {
    _cellBoard[row][col] = _cellBoard[row][col].flagCell();
    return this;
  }

  Board turnToLandMineCell(int row, int col) {
    _cellBoard[row][col] = _cellBoard[row][col].turnToLandMineCell();
    return this;
  }

  bool isLandMine(int row, int col) {
    return _cellBoard[row][col].isLandMine();
  }

  String getSign(int row, int col) {
    return _cellBoard[row][col].getSign();
  }

  Board updateLandMineCell(int row, int col) {
    _cellBoard[row][col] = _cellBoard[row][col].turnToLandMineCountCell();
    return this;
  }

  Board updateNearByLandMineCount(int row, int col, int count) {
    _cellBoard[row][col] =
        _cellBoard[row][col].updateNearByLandMineCount(count);
    return this;
  }

  bool isClosed(int row, int col) {
    return _cellBoard[row][col].isClosed();
  }

  bool checkIfAllCellOpened() {
    return _cellBoard.every((row) => row.every((cell) => !cell.isClosed()));
  }

  bool isNearByLandMine(int row, int col) {
    return _cellBoard[row][col].isNearByLandMine();
  }

  CellBoard turnToLandMineCountCell(int row, int col) {
    _cellBoard[row][col] = _cellBoard[row][col].turnToLandMineCountCell();
    return _cellBoard;
  }

  CellBoard openCell(int row, int col) {
    if (row < 0 || row >= getRowSize() || col < 0 || col >= getColSize()) {
      return _cellBoard;
    }

    if (!isClosed(row, col)) return _cellBoard;

    if (isLandMineCell(row, col)) return _cellBoard;

    if (isNearByLandMine(row, col)) {
      turnToLandMineCountCell(row, col);
      return _cellBoard;
    }

    _cellBoard[row][col] = _cellBoard[row][col].openCell();

    openCell(row - 1, col - 1);
    openCell(row - 1, col);
    openCell(row - 1, col + 1);
    openCell(row, col - 1);
    openCell(row, col + 1);
    openCell(row + 1, col - 1);
    openCell(row + 1, col);
    openCell(row + 1, col + 1);

    return _cellBoard;
  }

  bool isLandMineCell(int row, int col) {
    return _cellBoard[row][col].isLandMine();
  }
}
