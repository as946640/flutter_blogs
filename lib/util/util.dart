import 'dart:async';

debounceClick(Function func,
    {Duration delay = const Duration(milliseconds: 500)}) {
  Timer? timer;
  void target() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call();
    });
  }

  return target;
}
