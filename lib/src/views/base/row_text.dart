import 'package:flutter/material.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';

class RowText extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const RowText({
    Key? key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ?? h3.copyWith(
              color: kGreyTextColor,
            ),
          ),
          Text(
            value,
            style: valueStyle ?? h3.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}