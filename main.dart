import 'dart:math';
import 'dart:io';

class MinesweeperGame {
  static List<List<String>> board =
      List.generate(8, (_) => List.generate(10, (_) => '□'));
  static List<List<int>> landMineCounts =
      List.generate(8, (_) => List.generate(10, (_) => 0));
  static List<List<bool>> landMines =
      List.generate(8, (_) => List.generate(10, (_) => false));
  static int gameStatus = 0; // 0: 게임 중, 1: 승리, -1: 패배

  static void main(List<String> args) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print('지뢰찾기 게임 시작!');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');

    Random random = Random();
    for (int i = 0; i < 10; i++) {
      int col = random.nextInt(10);
      int row = random.nextInt(8);
      landMines[row][col] = true;
    }

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 10; j++) {
        int count = 0;
        if (!landMines[i][j]) {
          if (i - 1 >= 0 && j - 1 >= 0 && landMines[i - 1][j - 1]) count++;
          if (i - 1 >= 0 && landMines[i - 1][j]) count++;
          if (i - 1 >= 0 && j + 1 < 10 && landMines[i - 1][j + 1]) count++;
          if (j - 1 >= 0 && landMines[i][j - 1]) count++;
          if (j + 1 < 10 && landMines[i][j + 1]) count++;
          if (i + 1 < 8 && j - 1 >= 0 && landMines[i + 1][j - 1]) count++;
          if (i + 1 < 8 && landMines[i + 1][j]) count++;
          if (i + 1 < 8 && j + 1 < 10 && landMines[i + 1][j + 1]) count++;
          landMineCounts[i][j] = count;
        }
      }
    }

    while (true) {
      print('   a b c d e f g h i j');
      for (int i = 0; i < 8; i++) {
        stdout.write('${i + 1}  ');
        for (int j = 0; j < 10; j++) {
          stdout.write('${board[i][j]} ');
        }
        print('');
      }

      if (gameStatus == 1) {
        print('지뢰를 모두 찾았습니다. GAME CLEAR!');
        break;
      }
      if (gameStatus == -1) {
        print('지뢰를 밟았습니다. GAME OVER!');
        break;
      }

      print('\n선택할 좌표를 입력하세요. (예: a1)');
      String input = stdin.readLineSync()!;
      print('선택한 셀에 대한 행위를 선택하세요. (1: 오픈, 2: 깃발 꽂기)');
      String input2 = stdin.readLineSync()!;

      int col = input.codeUnitAt(0) - 'a'.codeUnitAt(0);
      int row = int.parse(input.substring(1)) - 1;

      if (input2 == '2') {
        board[row][col] = '⚑';
        if (_checkWinCondition()) gameStatus = 1;
      } else if (input2 == '1') {
        if (landMines[row][col]) {
          board[row][col] = '☼';
          gameStatus = -1;
          continue;
        } else {
          open(row, col);
          if (_checkWinCondition()) gameStatus = 1;
        }
      } else {
        print('잘못된 번호를 선택하셨습니다.');
      }
    }
  }

  static void open(int row, int col) {
    if (row < 0 || row >= 8 || col < 0 || col >= 10) return;
    if (board[row][col] != '□') return;
    if (landMines[row][col]) return;

    if (landMineCounts[row][col] != 0) {
      board[row][col] = landMineCounts[row][col].toString();
    } else {
      board[row][col] = '■';
      open(row - 1, col - 1);
      open(row - 1, col);
      open(row - 1, col + 1);
      open(row, col - 1);
      open(row, col + 1);
      open(row + 1, col - 1);
      open(row + 1, col);
      open(row + 1, col + 1);
    }
  }

  static bool _checkWinCondition() {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 10; j++) {
        if (board[i][j] == '□') return false;
      }
    }
    return true;
  }
}

void main(List<String> args) {
  MinesweeperGame.main(args);
}
