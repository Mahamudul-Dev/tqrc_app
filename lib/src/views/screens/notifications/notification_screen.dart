import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/notification_controller.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';
import 'package:tqrc_app/src/views/screens/notifications/components/notifications_item_builder.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'Notifications'.tr),
            Expanded(
              child: Obx(() {
                return notificationController.isLoading.value
                    ? const KCustomLoader()
                    : notificationController.notificationList.isEmpty
                        ? const NoDataFound()
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: notificationController.notificationList.length,
                            itemBuilder: (context, index) =>
                                NotificationsItemBuilder(
                              onTap: () {
                                if (notificationController.notificationList[index].read == 0) {
                                  notificationController.updateNotification(
                                    notificationController.notificationList[index].id!,
                                  );
                                }
                              },
                              isNew: true,
                              notificationData: notificationController.notificationList[index],
                            ),
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
