class Cell {
  static String get _closedCellSign => '□';
  static String get _flagCellSign => '⚑';
  static String get _landMineCellSign => '☼';
  static String get _openedCellSign => '■';

  final String _sign;
  final int _nearbyLandMineCount;
  final bool _isLandMine;

  Cell({
    required String sign,
    required int nearByLandMinCount,
    required bool isLandMine,
  })  : _sign = sign,
        _nearbyLandMineCount = nearByLandMinCount,
        _isLandMine = isLandMine;

  get sign => _sign;

  String getSign() {
    return _sign;
  }

  factory Cell.of(
      {required String sign,
      required int nearByLandMinCount,
      required bool isLandMine}) {
    return Cell(
      sign: sign,
      nearByLandMinCount: nearByLandMinCount,
      isLandMine: isLandMine,
    );
  }

  factory Cell.createClosed() {
    return Cell.of(
      sign: _closedCellSign,
      nearByLandMinCount: 0,
      isLandMine: false,
    );
  }

  Cell flagCell() {
    return Cell.of(
      sign: _flagCellSign,
      nearByLandMinCount: 0,
      isLandMine: _isLandMine,
    );
  }

  Cell turnToLandMineCell() {
    return Cell.of(
      sign: _landMineCellSign,
      nearByLandMinCount: 0,
      isLandMine: _isLandMine,
    );
  }

  Cell turnToLandMineCountCell() {
    return Cell.of(
      sign: _nearbyLandMineCount.toString(),
      nearByLandMinCount: _nearbyLandMineCount,
      isLandMine: _isLandMine,
    );
  }

  Cell openCell() {
    return Cell.of(
      sign: _openedCellSign,
      nearByLandMinCount: _nearbyLandMineCount,
      isLandMine: _isLandMine,
    );
  }

  Cell updateNearByLandMineCount(int count) {
    return Cell.of(
      sign: _sign,
      nearByLandMinCount: count,
      isLandMine: _isLandMine,
    );
  }

  Cell updateLandMine() {
    return Cell.of(
      sign: _sign,
      nearByLandMinCount: _nearbyLandMineCount,
      isLandMine: true,
    );
  }

  bool isClosed() {
    return _sign == _closedCellSign;
  }

  bool isNearByLandMine() {
    return _nearbyLandMineCount > 0;
  }

  bool isLandMine() {
    return _isLandMine;
  }
}
