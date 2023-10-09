import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/controllers/auth_controller.dart';
import 'package:tqrc_app/src/models/user_info.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/dashed_line_painter.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';

import 'components/info_card.dart';
import 'components/profile_image_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>()..getUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'Profile'.tr),
            Expanded(
              child: _buildProfileBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context) {
    return Obx(() {
      if (authController.isFetchingUserData.value) {
        return const KCustomLoader();
      } else {
        UserInfo user = authController.userInfo.value;
        return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  /// profile image
                  addVerticalSpace(Dimensions.paddingSizeSmall),
                  ProfileImageWidget(authController: authController),

                  /// user name
                  addVerticalSpace(Dimensions.paddingSizeSmall),
                  Text(
                    "${user.firstname} ${user.lastname}",
                    style: GoogleFonts.roboto(
                      textStyle: h2.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),

                  /// dashedLine
                  addVerticalSpace(Dimensions.paddingSizeLarge),
                  SizedBox(
                    width: Get.width,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                    ),
                  ),

                  /// profile info card and language selector widget
                  addVerticalSpace(Dimensions.paddingSizeDefault),
                  ProfileInfoCard(user: user),

                  /// logout button
                  addVerticalSpace(25),
                  _buildLogoutButton(context),

                  /// padding in bottom
                  addVerticalSpace(40),
                ],
              ),
            );
      }
    });
  }

  Widget _buildLogoutButton(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: KButton(
          onPressed: () async {
            bool? result = await kConfirmDialog(
              context: context,
              title: 'Are you sure you want to logout?'.tr,
              negativeActionText: 'Cancel'.tr,
              positiveActionText: 'Logout'.tr,
            );

            if (result!) {
              authController.logout();
            }
          },
          child: authController.isLoading.value
              ? Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: kWhite,
                  ),
                )
              : Text(
                  'Logout'.tr,
                  style: GoogleFonts.roboto(
                    textStyle: h2.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
      );
}
