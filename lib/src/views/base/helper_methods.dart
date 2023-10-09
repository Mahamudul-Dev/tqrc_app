import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';

Widget addVerticalSpace(double space) {
  return SizedBox(height: space);
}

Widget addHorizontalSpace(double space) {
  return SizedBox(width: space);
}

String getFullLocaleDate(DateTime dateTime) {
  return DateFormat('EEEE dd MMMM yyyy', '${Get.locale}')
      .format(dateTime)
      .replaceAll('.', '');
}

String getShortLocaleDate(DateTime dateTime) {
  return DateFormat('EEE dd MMM yyyy', '${Get.locale}')
      .format(dateTime)
      .replaceAll('.', '');
}

String getShortLocaleDateWithTime(DateTime dateTime) {
  return DateFormat('h:mm a, EEE dd MMM yyyy', '${Get.locale}')
      .format(dateTime)
      .replaceAll('.', '');
}

void kSnackBar({required String message, required Color bgColor}) {
  if (!Get.isSnackbarOpen) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: bgColor,
        message: message,
        maxWidth: 1170,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(10),
        borderRadius: 5,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}

/// to check internet connection
Future<bool> get hasInternet async {
  var result = await (Connectivity().checkConnectivity());
  if (result == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}

/// to send request in server with async system
class DeBouncer {
  int? milliseconds;
  VoidCallback? action;
  static Timer? timer;

  static run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

void kPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}

Future<bool?> kConfirmDialog({
  required BuildContext context,
  required String title,
  required String negativeActionText,
  required String positiveActionText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          icon: Icon(
            Icons.question_mark,
            color: mainColor,
          ),
          title: Text(
            title,
            style: h2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(
                negativeActionText,
                style: h4.copyWith(
                  color: kGrey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text(
                positiveActionText,
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
            ),
          ],
        );
      });
}

Future<bool?> customDialog({
  required BuildContext context,
  required String title,
  required AlignmentGeometry dialogPosition,
  List<Widget>? actions,
  Widget? content,
  bool barrierDismissible = false,
}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: content,
          ),
          insetPadding: EdgeInsets.all(
            Dimensions.paddingSizeDefault,
          ),
          alignment: dialogPosition,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: h2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: actions,
        );
      });
}

Future customBottomSheet({
  required BuildContext context,
  double horizontalMargin = 0,
  required Widget content,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radiusDefault),
        topRight: Radius.circular(Dimensions.radiusDefault),
      ),
    ),
    constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - horizontalMargin),
    builder: (context) {
      return content;
    },
  );
}
