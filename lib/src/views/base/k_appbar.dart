import 'package:flutter/material.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';

class KAppBar extends StatelessWidget {
  KAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var appBarWidth = AppBar().preferredSize.width;
    return Container(
      height: appBarHeight,
      width: appBarWidth,
      alignment: Alignment.centerLeft,
      padding: leading == null
          ? EdgeInsets.only(left: Dimensions.paddingSizeSmall)
          : EdgeInsets.zero,
      margin: EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault,
        top: Dimensions.paddingSizeSmall,
        bottom: Dimensions.paddingSizeExtraLarge,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: _boxShadows,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions ?? [],
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeSmall,
        ),
      ),
    );
  }

  final List<BoxShadow> _boxShadows = [
    BoxShadow(
      color: kShadowColor,
      blurRadius: 8,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: kShadowColor,
      blurRadius: 4,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    )
  ];
}
