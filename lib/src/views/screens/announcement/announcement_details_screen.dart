import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/models/announcement_data.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  const AnnouncementDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnouncementData data = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KAppBarWithBack(title: data.title ?? "No Title"),
            Expanded(
              child: _buildAnnouncementDetailsBody(data),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementDetailsBody(AnnouncementData data) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.date ?? '',
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
            addVerticalSpace(Dimensions.paddingSizeExtraSmall),
            Text(
              data.description ?? '',
              textAlign: TextAlign.justify,
              style: h4.copyWith(
                color: kGreyTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
