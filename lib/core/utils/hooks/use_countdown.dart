import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

(int, bool) useCountdown(int initialSeconds) {
  final count = useState(initialSeconds);
  final isActive = useState(true);

  useEffect(() {
    Timer? timer;

    if (isActive.value) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (count.value > 0) {
          count.value--;
        } else {
          isActive.value = false;
          timer?.cancel();
        }
      });
    }

    return () => timer?.cancel();
  }, [isActive.value]);

  return (count.value, isActive.value);
}
