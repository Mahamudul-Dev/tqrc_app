import 'package:get/get.dart';
import 'package:tqrc_app/src/models/notification_data.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notificationList = <NotificationData>[].obs;
  var totalUnreadNotification = 0.obs;

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }

  Future<void> getNotificationList() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(endPoint: Api.notificationList),
      );

      if (responseBody != null) {

        notificationList.value = [];
        totalUnreadNotification.value = 0;

        for (var notification in responseBody) {
          notificationList.add(NotificationData.fromJson(notification));
          if(NotificationData.fromJson(notification).read == 0){
            totalUnreadNotification.value++;
          }
        }
      } else {
        throw 'Unable to load notification list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  void updateNotification(int id) async {
    try {
      isLoading(true);

      final params = <String, dynamic>{
        'id': '$id',
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.updateNotificationStatus,
          params: params,
        ),
      );

      if (responseBody != null) {
        kSnackBar(
          message: 'Status updated!',
          bgColor: successColor,
        );
        await getNotificationList();
      } else {
        throw 'Unable to update status!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}
