import 'package:get/get.dart';
import 'package:tqrc_app/src/models/announcement_data.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class AnnouncementController extends GetxController{
  var isLoading = false.obs;
  var announcementList = <AnnouncementData>[].obs;

  @override
  void onInit() {
    getAnnouncementList();
    super.onInit();
  }

  Future<void> getAnnouncementList() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(endPoint: Api.announcementList),
      );

      if (responseBody != null) {
        announcementList.value = [];
        for(var announcement in responseBody){
          announcementList.add(AnnouncementData.fromJson(announcement));
        }
      } else {
        throw 'Unable to load announcement list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}