import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/models/announcement_data.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class AnnouncementItem extends StatelessWidget {
  final AnnouncementData data;

  const AnnouncementItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        RouteGenerator.announcementDetails,
        arguments: data,
      ),
      child: Container(
        height: 140,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title ?? '',
              style: h3.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            addVerticalSpace(5),
            Text(
              data.date!.isNotEmpty
                  ? DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(data.date!),
                    )
                  : '',
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
            addVerticalSpace(2),
            Text(
              data.description ?? '',
              maxLines: 3,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
