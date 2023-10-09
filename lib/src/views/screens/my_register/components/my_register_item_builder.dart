import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/models/my_register_data.dart';
import 'package:tqrc_app/src/services/extensions/string_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/status_builder.dart';

class MyRegisterItemBuilder extends StatelessWidget {
  final MyRegisterData data;

  const MyRegisterItemBuilder({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: IntrinsicHeight(
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
                  addVerticalSpace(5),
                  StatusBuilder(
                    status: data.status!,
                    color: mainColor,
                  ),
                ],
              ),
            ),
            addHorizontalSpace(Dimensions.paddingSizeSmall),
            TextButton(
              onPressed: () => Get.toNamed(
                RouteGenerator.myRegisterDetails,
                arguments: data,
              ),
              child: Text(
                'View'.tr,
                style: h4.copyWith(
                  color: mainColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
