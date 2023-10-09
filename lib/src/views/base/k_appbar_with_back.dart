import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/k_appbar.dart';
import 'package:tqrc_app/src/views/base/k_appbar_home_icon.dart';
import 'package:tqrc_app/src/views/base/k_appbar_notification_icon.dart';

import 'helper_methods.dart';

class KAppBarWithBack extends StatelessWidget {
  final String title;

  const KAppBarWithBack({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KAppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: AppBar().preferredSize.height,
          width: AppBar().preferredSize.height,
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: mainColor,
          ),
        ),
      ),
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.manrope(
          textStyle: h4.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actions: [
        const KAppBarHomeIcon(),
        addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
        const KAppBarNotificationIcon(),
      ],
    );
  }
}
