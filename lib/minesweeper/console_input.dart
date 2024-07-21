import 'dart:io';

class ConsoleInputCell {
  final int col;
  final int row;

  ConsoleInputCell({
    required this.col,
    required this.row,
  });
}

class ConsoleInput {
  ConsoleInputCell readCell() {
    final input = _readLine();
    final row = _convertRowFrom(input);
    final col = _covertColFrom(input);

    return ConsoleInputCell(
      row: row,
      col: col,
    );
  }

  String readUserAction() {
    return _readLine();
  }

  String _readLine() {
    return stdin.readLineSync() ?? "";
  }

  int _convertRowFrom(String input) {
    final rowInput = input.substring(1);
    return int.parse(rowInput) - 1;
  }

  int _covertColFrom(String input) {
    return input.codeUnitAt(0) - 'a'.codeUnitAt(0);
  }
}
