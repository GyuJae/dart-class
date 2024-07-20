import 'dart:io';

import 'package:dart_playground/minesweeper/board.dart';

class MinesweeperGame {
  static int get _boardRowSize => 8;
  static int get _boardColSize => 10;
  static int get _landMineCount => 10;

  static Board board = Board.fromSize(
    rowSize: _boardRowSize,
    colSize: _boardColSize,
    landMineCount: _landMineCount,
  );

  static int gameStatus = 0; // 0: 게임 중, 1: 승리, -1: 패배

  void run() {
    _showStartGameComments();

    while (true) {
      try {
        board.showBoard();

        if (doesUserWinTheGame) {
          print('지뢰를 모두 찾았습니다. GAME CLEAR!');
          break;
        }

        if (doseUserLoseTheGame) {
          print('지뢰를 밟았습니다. GAME OVER!');
          break;
        }

        String cellInputCol = _getCellInputCol();
        String userActionInput = _getUserActionInput();

        int selectedCol = _covertColFrom(cellInputCol);
        int selectedRow = _convertRowFrom(cellInputCol.substring(1));

        actionOnCell(userActionInput, selectedRow, selectedCol);
      } catch (e) {
        print(e);
      }
    }
  }

  static void actionOnCell(
      String userActionInput, int selectedRow, int selectedCol) {
    if (doseUserChooseToPlantFlag(userActionInput)) {
      board.flag(selectedRow, selectedCol);
      _checkIfGameOver();
      return;
    }

    if (!doseUserChooseToOpenCell(userActionInput)) {
      print('잘못된 번호를 선택하셨습니다.');
      return;
    }

    if (board.isLandMine(selectedRow, selectedCol)) {
      board.turnToLandMineCell(selectedRow, selectedCol);
      _changeGameStatusToLose();
      return;
    }

    _open(selectedRow, selectedCol);
    _checkIfGameOver();
  }

  static void _changeGameStatusToLose() {
    gameStatus = -1;
  }

  static bool doseUserChooseToOpenCell(String userActionInput) =>
      userActionInput == '1';

  static void _checkIfGameOver() {
    if (board.checkIfAllCellOpened()) _changeGameStatusToWin();
  }

  static int _changeGameStatusToWin() => _changeGameStatusToWin();

  static bool doseUserChooseToPlantFlag(String userActionInput) =>
      userActionInput == '2';

  static String _getCellInputCol() {
    print('\n선택할 좌표를 입력하세요. (예: a1)');
    return stdin.readLineSync()!;
  }

  static String _getUserActionInput() {
    print('선택한 셀에 대한 행위를 선택하세요. (1: 오픈, 2: 깃발 꽂기)');
    return stdin.readLineSync()!;
  }

  static bool get doseUserLoseTheGame => gameStatus == -1;

  static bool get doesUserWinTheGame => gameStatus == 1;

  static int _convertRowFrom(String row) {
    return int.parse(row) - 1;
  }

  static int _covertColFrom(String col) {
    final colPosition = col.codeUnitAt(0) - 'a'.codeUnitAt(0);

    if (colPosition < 0 || colPosition >= _boardColSize) {
      throw Exception('잘못된 입력입니다.');
    }

    return colPosition;
  }

  static void _showStartGameComments() {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print('지뢰찾기 게임 시작!');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }

  static void _open(int row, int col) {
    if (row < 0 ||
        row >= board.getRowSize() ||
        col < 0 ||
        col >= board.getColSize()) {
      return;
    }

    if (!board.isClosed(row, col)) return;

    if (board.isLandMineCell(row, col)) return;

    if (board.isNearByLandMine(row, col)) {
      board.turnToLandMineCountCell(row, col);
      return;
    }

    board.openCell(row, col);

    _open(row - 1, col - 1);
    _open(row - 1, col);
    _open(row - 1, col + 1);
    _open(row, col - 1);
    _open(row, col + 1);
    _open(row + 1, col - 1);
    _open(row + 1, col);
    _open(row + 1, col + 1);
  }
}
