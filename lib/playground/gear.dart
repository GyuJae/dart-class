class Gear {
  int chainring;
  int cog;
  Wheel wheel;

  Gear({
    required this.chainring,
    required this.cog,
    required this.wheel,
  });

  /// 기어비
  double ratio() {
    return chainring / cog;
  }

  /// 기어인치
  double gearInches() {
    return ratio() * wheel.diameter();
  }
}

class Wheel {
  /// 바퀴테 둘레
  double rim;

  /// 타이어 높이
  double tire;

  Wheel({
    required this.rim,
    required this.tire,
  });

  /// 바퀴의 지름
  double diameter() {
    return rim + (tire * 2);
  }

  /// 바퀴의 둘레
  double circumference() {
    return diameter() * 3.14159;
  }
}

// 요규사항 -> use case 라고 생각