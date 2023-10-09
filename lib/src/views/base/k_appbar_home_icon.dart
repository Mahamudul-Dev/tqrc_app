import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';

class KAppBarHomeIcon extends StatelessWidget {
  const KAppBarHomeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (RouteGenerator.home != ModalRoute.of(context)!.settings.name) {
          Get.offAllNamed(RouteGenerator.home);
        }
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.home,
          color: mainColor,
        ),
      ),
    );
  }
}
