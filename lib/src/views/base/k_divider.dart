import 'package:flutter/material.dart';

import '../../utils/color.dart';

class KDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  const KDivider({Key? key, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ?? kDividerColor,
    );
  }
}
