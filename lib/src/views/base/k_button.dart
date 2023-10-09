import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/dimensions.dart';

class KButton extends StatelessWidget {
  const KButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.bgColor,
    this.height,
    this.width,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;
  final Color? bgColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      color: bgColor ?? mainColor,
      height: height ?? 42,
      minWidth: width ?? Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
      ),
      elevation: 0,
      child: child,
    );
  }
}
