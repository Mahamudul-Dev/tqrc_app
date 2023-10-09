import 'package:flutter/material.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';

class StatusBuilder extends StatelessWidget {
  final String status;
  final Color color;

  const StatusBuilder({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
        color: color.withOpacity(0.2),
      ),
      child: Text(
        status,
        style: h6.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
