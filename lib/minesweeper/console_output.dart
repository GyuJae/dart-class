import 'package:dart_playground/minesweeper/exceptions.dart';

class ConsoleOutput {
  void printGameWinningComment() {
    print('지뢰를 모두 찾았습니다. GAME CLEAR!');
  }

  void printGameLosingComment() {
    print('지뢰를 밟았습니다. GAME OVER!');
  }

  void printChooseWrongNumberComment() {
    print('잘못된 번호를 선택하셨습니다.');
  }

  void printCommentForChooseCell() {
    print('\n선택할 좌표를 입력하세요. (예: a1)');
  }

  void printCommentForUserAction() {
    print('선택한 셀에 대한 행위를 선택하세요. (1: 오픈, 2: 깃발 꽂기)');
  }

  void printAppExceptionMessage(AppException e) {
    print(e.message);
  }

  void printStartGameComments() {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print('지뢰찾기 게임 시작!');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }
}
