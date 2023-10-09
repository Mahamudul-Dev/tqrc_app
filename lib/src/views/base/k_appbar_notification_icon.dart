import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/controllers/notification_controller.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';

class KAppBarNotificationIcon extends StatelessWidget {
  const KAppBarNotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int totalUnreadNotification =
          Get.find<NotificationController>().totalUnreadNotification.value;
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(RouteGenerator.notifications),
            child: Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications,
                color: mainColor,
              ),
            ),
          ),
          if (totalUnreadNotification > 0)
            Positioned(
              top: 4,
              right: 2,
              child: Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kRed,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$totalUnreadNotification',
                  style: h5.copyWith(
                    color: kWhite,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
