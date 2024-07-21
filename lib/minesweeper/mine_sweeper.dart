import 'package:dart_playground/minesweeper/board.dart';
import 'package:dart_playground/minesweeper/console_input.dart';
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
  final ConsoleInput consoleInput = ConsoleInput();

  void run() {
    consoleOutput.printStartGameComments();

    while (true) {
      board.showBoard();

      if (doesUserWinTheGame) {
        consoleOutput.printGameWinningComment();
        break;
      }

      if (doseUserLoseTheGame) {
        consoleOutput.printGameLosingComment();
        break;
      }

      consoleOutput.printCommentForChooseCell();
      final ConsoleInputCell consoleInputCell = consoleInput.readCell();

      if (consoleInputCell.row < 0 || consoleInputCell.row >= _boardRowSize) {
        consoleOutput.printAppExceptionMessage(AppException('잘못된 입력입니다.'));
        continue;
      }

      if (consoleInputCell.col < 0 || consoleInputCell.col >= _boardColSize) {
        consoleOutput.printAppExceptionMessage(AppException('잘못된 입력입니다.'));
        continue;
      }

      consoleOutput.printCommentForUserAction();
      String userActionInput = consoleInput.readUserAction();

      actionOnCell(userActionInput, consoleInputCell.row, consoleInputCell.col);
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

    board.openCell(selectedRow, selectedCol);
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

  static bool get doseUserLoseTheGame => gameStatus == -1;

  static bool get doesUserWinTheGame => gameStatus == 1;
}
