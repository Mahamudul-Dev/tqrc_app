import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/announcement_controller.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';
import 'package:tqrc_app/src/views/screens/announcement/components/announcement_item.dart';

class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({Key? key}) : super(key: key);
  final announcementController = Get.find<AnnouncementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'Announcement'.tr),
            Expanded(
              child: _buildAnnouncementBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await announcementController.getAnnouncementList();
      },
      child: Obx(() {
        return announcementController.isLoading.value
            ? const KCustomLoader()
            : announcementController.announcementList.isEmpty
                ? const NoDataFound()
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: announcementController.announcementList.length,
                    itemBuilder: (context, index) => AnnouncementItem(
                      data: announcementController.announcementList[index],
                    ),
                    separatorBuilder: (context, index) => addVerticalSpace(
                      Dimensions.paddingSizeDefault,
                    ),
                  );
      }),
    );
  }
}
