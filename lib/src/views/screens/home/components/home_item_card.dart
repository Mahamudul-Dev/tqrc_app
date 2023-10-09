import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/services/extensions/build_context_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class HomeItemCard extends StatelessWidget {
  const HomeItemCard({
    Key? key,
    required this.iconData,
    this.title,
    this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = min(Get.height, Get.width);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size * 0.4,
        height: size * 0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: kWhite,
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: kItemShadowColor,
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: context.minSize * 0.2,
              color: mainColor,
            ),
            title == '' || title == null
                ? Container()
                : addVerticalSpace(Dimensions.paddingSizeSmall),
            title == '' || title == null
                ? Container()
                : Text(
                    title ?? "",
                    style: h4.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
