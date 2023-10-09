import 'dart:math';

import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext {
  void unFocusKeyboard() => FocusScope.of(this).unfocus();

  double get minSize => min(
        MediaQuery.of(this).size.height,
        MediaQuery.of(this).size.width,
      );
}
