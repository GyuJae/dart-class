import 'dart:math';
import 'dart:io';

class MinesweeperGame {
  static int get _boardRowSize => 8;
  static int get _boardColSize => 10;
  static int get _landMineCount => 10;
  static String get _closedCellSign => '□';
  static String get _flagCellSign => '⚑';
  static String get _landMineCellSign => '☼';
  static String get _openedCellSign => '■';

  static List<List<String>> board = List.generate(_boardRowSize,
      (_) => List.generate(_boardColSize, (_) => _closedCellSign));

  static List<List<int>> landMineCounts = List.generate(
      _boardRowSize, (_) => List.generate(_boardColSize, (_) => 0));
  static List<List<bool>> landMines = List.generate(
      _boardRowSize, (_) => List.generate(_boardColSize, (_) => false));
  static int gameStatus = 0; // 0: 게임 중, 1: 승리, -1: 패배

  static void main(List<String> args) {
    _showStartGameComments();
    _initializeGame();

    while (true) {
      try {
        _showBoard();

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
      board[selectedRow][selectedCol] = _flagCellSign;
      _checkIfGameOver();
      return;
    }

    if (!doseUserChooseToOpenCell(userActionInput)) {
      print('잘못된 번호를 선택하셨습니다.');
      return;
    }

    if (_isLandMineCell(selectedRow, selectedCol)) {
      board[selectedRow][selectedCol] = _landMineCellSign;
      _changeGameStatusToLose();
      return;
    }

    _open(selectedRow, selectedCol);
    _checkIfGameOver();
  }

  static void _changeGameStatusToLose() {
    gameStatus = -1;
  }

  static bool _isLandMineCell(int selectedRow, int selectedCol) =>
      landMines[selectedRow][selectedCol];

  static bool doseUserChooseToOpenCell(String userActionInput) =>
      userActionInput == '1';

  static void _checkIfGameOver() {
    if (_checkIfAllCellOpened()) _changeGameStatusToWin();
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

  static void _showBoard() {
    print('   a b c d e f g h i j');
    for (int row = 0; row < _boardRowSize; row++) {
      stdout.write('${row + 1}  ');
      for (int col = 0; col < _boardColSize; col++) {
        stdout.write('${board[row][col]} ');
      }
      print('');
    }
  }

  static void _initializeGame() {
    Random random = Random();
    for (int i = 0; i < _landMineCount; i++) {
      int col = random.nextInt(_boardColSize);
      int row = random.nextInt(_boardRowSize);
      landMines[row][col] = true;
    }

    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 10; col++) {
        int count = 0;
        if (!_isLandMineCell(row, col)) {
          if (row - 1 >= 0 && col - 1 >= 0 && landMines[row - 1][col - 1]) {
            count++;
          }
          if (row - 1 >= 0 && landMines[row - 1][col]) count++;
          if (row - 1 >= 0 && col + 1 < 10 && landMines[row - 1][col + 1]) {
            count++;
          }
          if (col - 1 >= 0 && landMines[row][col - 1]) count++;
          if (col + 1 < 10 && landMines[row][col + 1]) count++;
          if (row + 1 < 8 && col - 1 >= 0 && landMines[row + 1][col - 1]) {
            count++;
          }
          if (row + 1 < 8 && landMines[row + 1][col]) count++;
          if (row + 1 < 8 && col + 1 < 10 && landMines[row + 1][col + 1]) {
            count++;
          }
          landMineCounts[row][col] = count;
        }
      }
    }
  }

  static void _showStartGameComments() {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print('지뢰찾기 게임 시작!');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }

  static void _open(int row, int col) {
    if (row < 0 || row >= 8 || col < 0 || col >= 10) return;
    if (board[row][col] != _closedCellSign) return;
    if (_isLandMineCell(row, col)) return;

    if (landMineCounts[row][col] != 0) {
      board[row][col] = landMineCounts[row][col].toString();
    } else {
      board[row][col] = _openedCellSign;
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

  static bool _checkIfAllCellOpened() {
    return board.expand((row) => row).every((cell) => cell != _closedCellSign);
  }
}

void main(List<String> args) {
  MinesweeperGame.main(args);
}
