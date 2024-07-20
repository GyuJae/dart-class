import 'dart:io';
import 'dart:math';

import 'package:dart_playground/minesweeper/cell.dart';

typedef CellBoard = List<List<Cell>>;

class Board {
  final int _rowSize;
  final int _colSize;
  final int _landMineCount;
  final CellBoard _cellBoard;

  Board({
    required int rowSize,
    required int colSize,
    required int landMineCount,
    required List<List<Cell>> cellBoard,
  })  : _rowSize = rowSize,
        _colSize = colSize,
        _landMineCount = landMineCount,
        _cellBoard = cellBoard;

  factory Board.fromSize({
    required int rowSize,
    required int colSize,
    required int landMineCount,
  }) {
    CellBoard cellBoard = List.generate(
      rowSize,
      (_) => List.generate(
        colSize,
        (_) => Cell.createClosed(),
      ),
    );

    Random random = Random();
    for (int i = 0; i < landMineCount; i++) {
      int row = random.nextInt(rowSize);
      int col = random.nextInt(colSize);
      cellBoard[row][col] = cellBoard[row][col].updateLandMine();
    }

    for (int row = 0; row < rowSize; row++) {
      for (int col = 0; col < colSize; col++) {
        int count = 0;
        if (!cellBoard[row][col].isLandMine()) {
          if (row - 1 >= 0 &&
              col - 1 >= 0 &&
              cellBoard[row - 1][col - 1].isLandMine()) {
            count++;
          }
          if (row - 1 >= 0 && cellBoard[row - 1][col].isLandMine()) count++;
          if (row - 1 >= 0 &&
              col + 1 < colSize &&
              cellBoard[row - 1][col + 1].isLandMine()) {
            count++;
          }
          if (col - 1 >= 0 && cellBoard[row][col - 1].isLandMine()) count++;
          if (col + 1 < colSize && cellBoard[row][col + 1].isLandMine()) {
            count++;
          }
          if (row + 1 < rowSize &&
              col - 1 >= 0 &&
              cellBoard[row + 1][col - 1].isLandMine()) {
            count++;
          }
          if (row + 1 < rowSize && cellBoard[row + 1][col].isLandMine()) {
            count++;
          }
          if (row + 1 < rowSize &&
              col + 1 < colSize &&
              cellBoard[row + 1][col + 1].isLandMine()) {
            count++;
          }
          cellBoard[row][col] =
              cellBoard[row][col].updateNearByLandMineCount(count);
        }
      }
    }

    return Board(
      rowSize: rowSize,
      colSize: colSize,
      landMineCount: landMineCount,
      cellBoard: cellBoard,
    );
  }

  int getRowSize() {
    return _rowSize;
  }

  int getColSize() {
    return _colSize;
  }

  int getLandMineCount() {
    return _landMineCount;
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

  String _getSign(int row, int col) {
    return _cellBoard[row][col].getSign();
  }

  Board updateLandMineCell(int row, int col) {
    _cellBoard[row][col] = _cellBoard[row][col].turnToLandMineCountCell();
    return this;
  }

  void showBoard() {
    print('   a b c d e f g h i j');
    for (int row = 0; row < _rowSize; row++) {
      stdout.write('${row + 1}  ');
      for (int col = 0; col < _colSize; col++) {
        stdout.write('${_getSign(row, col)} ');
      }
      print('');
    }
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
    _cellBoard[row][col] = _cellBoard[row][col].openCell();
    return _cellBoard;
  }

  bool isLandMineCell(int row, int col) {
    return _cellBoard[row][col].isLandMine();
  }
}
