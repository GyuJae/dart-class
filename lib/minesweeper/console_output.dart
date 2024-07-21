import 'dart:io';

import 'package:dart_playground/minesweeper/board.dart';
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

  void showBoard(Board board) {
    print("    ${_generateAlphabets(board.getColSize())}");
    for (int row = 0; row < board.getRowSize(); row++) {
      stdout.write('${(row + 1).toString().padLeft(2)}  ');
      for (int col = 0; col < board.getColSize(); col++) {
        stdout.write('${board.getSign(row, col).toString().padRight(1)} ');
      }
      print('');
    }
  }

  String _generateAlphabets(int col) {
    var alphabets = '';
    for (int i = 0; i < col; i++) {
      alphabets += '${String.fromCharCode(i + 97)} ';
    }

    return alphabets;
  }
}
