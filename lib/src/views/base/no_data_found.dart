import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/asset_path.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import 'helper_methods.dart';

class NoDataFound extends StatelessWidget {
  final VoidCallback? searchAgain;
  final String? subTitle;

  const NoDataFound({
    Key? key,
    this.searchAgain,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPath.noDataFound,
              width: context.height * 0.25,
              height: context.height * 0.25,
              fit: BoxFit.cover,
            ),
            Text(
              'No Data Found!',
              style: h2.copyWith(
                color: kBlackLight,
                fontWeight: FontWeight.w700,
              ),
            ),
            addVerticalSpace(5),
            Text(
              subTitle ?? '',
              textAlign: TextAlign.center,
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
            // addVerticalSpace(16),
            // KButton(
            //   onPressed: searchAgain,
            //   bgColor: kRedMedium,
            //   width: context.width * 0.4,
            //   borderRadius: 100,
            //   child: Text(
            //     'Search Again',
            //     style: GoogleFonts.roboto(
            //       textStyle: h3.copyWith(
            //         color: kWhite,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
