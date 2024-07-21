import 'package:dart_playground/minesweeper/board.dart';
import 'package:dart_playground/minesweeper/console_input.dart';
import 'package:dart_playground/minesweeper/console_output.dart';
import 'package:dart_playground/minesweeper/exceptions.dart';
import 'package:dart_playground/minesweeper/game_level/middle.dart';

class MinesweeperGame {
  static int gameStatus = 0; // 0: 게임 중, 1: 승리, -1: 패배

  Board board = Board.fromLevel(
    level: Middle(),
  );

  final ConsoleOutput consoleOutput = ConsoleOutput();
  final ConsoleInput consoleInput = ConsoleInput();

  void run() {
    consoleOutput.printStartGameComments();

    while (true) {
      consoleOutput.showBoard(board);

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

      if (consoleInputCell.row < 0 ||
          consoleInputCell.row >= board.getRowSize()) {
        consoleOutput.printAppExceptionMessage(AppException('잘못된 입력입니다.'));
        continue;
      }

      if (consoleInputCell.col < 0 ||
          consoleInputCell.col >= board.getColSize()) {
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

  void _changeGameStatusToLose() {
    gameStatus = -1;
  }

  bool doseUserChooseToOpenCell(String userActionInput) =>
      userActionInput == '1';

  void _checkIfGameOver() {
    if (board.checkIfAllCellOpened()) _changeGameStatusToWin();
  }

  int _changeGameStatusToWin() => _changeGameStatusToWin();

  bool doseUserChooseToPlantFlag(String userActionInput) =>
      userActionInput == '2';

  bool get doseUserLoseTheGame => gameStatus == -1;

  bool get doesUserWinTheGame => gameStatus == 1;
}
