import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/src/models/notification_data.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class NotificationsItemBuilder extends StatelessWidget {
  final VoidCallback onTap;
  final bool isNew;
  final NotificationData notificationData;

  const NotificationsItemBuilder({
    Key? key,
    required this.onTap,
    required this.isNew,
    required this.notificationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              spreadRadius: 1,
              blurRadius: 4,
              color: kItemShadowColor,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            notificationData.text ?? "",
            style: h4.copyWith(
              fontWeight: notificationData.read == 0
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          subtitle: Text(
            notificationData.createdAt!.isNotEmpty
                ? DateFormat('dd-MM-yyyy, h:mm a').format(
                    DateTime.parse(
                      notificationData.createdAt!,
                    ),
                  )
                : '',
            style: h5.copyWith(
              color: kGrey,
            ),
          ),
          trailing: Icon(
            notificationData.read == 0 ? Icons.mail : Icons.mail_outline,
          ),
        ),
      ),
    );
  }
}
