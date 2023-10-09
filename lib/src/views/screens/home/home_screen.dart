import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/controllers/notification_controller.dart';
import 'package:tqrc_app/src/utils/asset_path.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar.dart';
import 'package:tqrc_app/src/views/base/k_appbar_home_icon.dart';
import 'package:tqrc_app/src/views/base/k_appbar_notification_icon.dart';

import 'components/home_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHomeAppBar(context),
            Expanded(child: _buildHomeBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeAppBar(BuildContext context) => KAppBar(
        title: Image.asset(AssetPath.appLogoWithText),
        actions: [
          const KAppBarHomeIcon(),
          addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
          const KAppBarNotificationIcon(),
        ],
      );

  Widget _buildHomeBody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeItemCard(
                    title: 'Announcement'.tr,
                    iconData: Icons.mic,
                    onTap: () => Get.toNamed(RouteGenerator.announcement),
                  ),
                  HomeItemCard(
                    title: 'Activities'.tr,
                    iconData: Icons.volunteer_activism,
                    onTap: () => Get.toNamed(RouteGenerator.activities),
                  ),
                ],
              ),
              addVerticalSpace(Dimensions.paddingSizeDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeItemCard(
                    title: 'Date Picker'.tr,
                    iconData: Icons.date_range,
                    onTap: () => Get.toNamed(RouteGenerator.datePicker),
                  ),
                  HomeItemCard(
                    title: 'My Register'.tr,
                    iconData: Icons.list,
                    onTap: () => Get.toNamed(RouteGenerator.myRegister),
                  ),
                ],
              ),
              addVerticalSpace(Dimensions.paddingSizeDefault),
              HomeItemCard(
                title: 'Profile'.tr,
                iconData: Icons.person,
                onTap: () => Get.toNamed(RouteGenerator.profile),
              ),
            ],
          ),
        ),
      );
}
