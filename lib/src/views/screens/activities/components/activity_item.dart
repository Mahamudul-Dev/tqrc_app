import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/models/activities_data.dart';
import 'package:tqrc_app/src/services/extensions/string_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/status_builder.dart';

class ActivityItem extends StatelessWidget {
  final ActivitiesData data;

  const ActivityItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.toNamed(
        RouteGenerator.activitiesDetails,
        arguments: [data.id, data.activityData],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// item content
          Container(
            height: 130,
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.marginSizeDefault,
            ),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: kItemShadowColor,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.date!.isNotEmpty
                            ? getShortLocaleDate(DateTime.parse(data.date ?? ""))
                            : '',
                        maxLines: 1,
                        style: h3.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      addVerticalSpace(2),
                      Text(
                        '${data.timeStart!.formatTime} - ${data.timeStop!.formatTime}',
                        maxLines: 1,
                        style: h5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      addVerticalSpace(5),
                      Text(
                        data.name ?? '',
                        style: h5.copyWith(
                          color: kGreyTextColor,
                        ),
                      ),
                      _buildRemarkText(),
                    ],
                  ),
                ),
                addHorizontalSpace(Dimensions.paddingSizeSmall),
                StatusBuilder(
                  status: data.activityData!.isNotEmpty
                      ? "Withdraw".tr
                      : "Signup".tr,
                  color: data.activityData!.isNotEmpty ? kGreen : kBlue,
                ),
              ],
            ),
          ),

          /// top line
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.marginSizeDefault,
            ),
            width: size.width,
            height: 10,
            decoration: BoxDecoration(
              color: data.activityData!.isNotEmpty ? kGreen : kBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusDefault),
                topRight: Radius.circular(Dimensions.radiusDefault),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRemarkText() {
    if (data.activityData!.isNotEmpty) {
      if (data.activityData!.first.remark != '') {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              '${'Remark'.tr}: ${data.activityData!.first.remark}',
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
