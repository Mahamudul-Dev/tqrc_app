import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/models/user_info.dart';
import 'package:tqrc_app/src/services/extensions/build_context_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/messages.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_divider.dart';
import 'package:tqrc_app/src/views/base/k_text_form_field.dart';
import 'package:tqrc_app/src/views/base/language_selector_widget.dart';

import 'info_item.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserInfo user;

  ProfileInfoCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
              color: kItemShadowColor,
            ),
          ],
        ),
        child: Column(
          children: [
            ProfileInfoItem(
              title: 'Name'.tr,
              data: "${user.firstname} ${user.lastname}",
              onPressed: () {
                nameFocusNode.requestFocus();
              },
              isEditable: false,
            ),
            KDivider(height: 26, color: kGreyMedium),
            ProfileInfoItem(
              title: 'Phone Number'.tr,
              data: user.phone ?? 'Not Set'.tr,
              onPressed: () {
                phoneFocusNode.requestFocus();
              },
              isEditable: false,
            ),
            KDivider(height: 26, color: kGreyMedium),
            ProfileInfoItem(
              title: 'Email'.tr,
              data: user.email ?? 'Not Set'.tr,
              onPressed: null,
              isEditable: false,
            ),
            KDivider(height: 26, color: kGreyMedium),
            LanguageSelectorWidget(),
          ],
        ),
      ),
    );
  }
}