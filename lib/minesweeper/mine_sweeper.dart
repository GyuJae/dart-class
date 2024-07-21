import 'dart:io';

import 'package:dart_playground/minesweeper/board.dart';
import 'package:dart_playground/minesweeper/console_output.dart';
import 'package:dart_playground/minesweeper/exceptions.dart';

class MinesweeperGame {
  static int get _boardRowSize => 8;
  static int get _boardColSize => 10;
  static int get _landMineCount => 10;
  static int gameStatus = 0; // 0: 게임 중, 1: 승리, -1: 패배

  static Board board = Board.fromSize(
    rowSize: _boardRowSize,
    colSize: _boardColSize,
    landMineCount: _landMineCount,
  );

  final ConsoleOutput consoleOutput = ConsoleOutput();

  void run() {
    consoleOutput.printStartGameComments();

    while (true) {
      try {
        board.showBoard();

        if (doesUserWinTheGame) {
          consoleOutput.printGameWinningComment();
          break;
        }

        if (doseUserLoseTheGame) {
          consoleOutput.printGameLosingComment();
          break;
        }

        String cellInputCol = _getCellInputCol();
        String userActionInput = _getUserActionInput();

        int selectedCol = _covertColFrom(cellInputCol);
        int selectedRow = _convertRowFrom(cellInputCol.substring(1));

        actionOnCell(userActionInput, selectedRow, selectedCol);
      } on AppException catch (e) {
        consoleOutput.printAppExceptionMessage(e);
      }
    }
  }

  void actionOnCell(String userActionInput, int selectedRow, int selectedCol) {
    if (doseUserChooseToPlantFlag(userActionInput)) {
      board.flag(selectedRow, selectedCol);
      _checkIfGameOver();
      return;
    }

    if (!doseUserChooseToOpenCell(userActionInput)) {
      consoleOutput.printChooseWrongNumberComment();
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

  String _getCellInputCol() {
    consoleOutput.printCommentForChooseCell();
    return stdin.readLineSync()!;
  }

  String _getUserActionInput() {
    consoleOutput.printCommentForUserAction();
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
      throw AppException('잘못된 입력입니다.');
    }

    return colPosition;
  }

  void _open(int row, int col) {
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
