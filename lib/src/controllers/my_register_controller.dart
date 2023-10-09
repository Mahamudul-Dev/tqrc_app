import 'package:get/get.dart';
import 'package:tqrc_app/src/models/my_register_data.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class MyRegisterController extends GetxController {
  var isLoading = false.obs;
  var myRegisterDataList = <MyRegisterData>[].obs;
  var pageNumber = 1.obs;
  var loadedCompleted = false.obs;
  var registerInstructor = ''.obs;
  var isInstructorLoading = false.obs;

  Future<void> refreshMyRegisterList() async {
    pageNumber.value = 1;
    await getMyRegisterList();
  }

  Future<void> getMyRegisterList() async {
    try {
      if (pageNumber.value == 1) {
        myRegisterDataList.value = [];
        isLoading(true);
        loadedCompleted(false);
      }

      var param = <String, dynamic>{};
      param['page'] = pageNumber.value.toString();
      param['perPage'] = "10";

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.myRegister,
          params: param,
        ),
      );

      if (responseBody != null) {
        if (responseBody["next_page_url"] == null) {
          loadedCompleted(true);
        } else {
          loadedCompleted(false);
        }

        var data = responseBody['data'];
        if (data != null) {
          for (var i in data) {
            myRegisterDataList.add(MyRegisterData.fromJson(i));
          }
        }
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getRegisterInstructor({required int planningId}) async {
    try {
      isInstructorLoading(true);

      var param = <String, dynamic>{};
      param['id'] = '$planningId';

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.getRegisterInstructor,
          params: param,
        ),
      );

      if (responseBody != null) {
        registerInstructor.value = '${responseBody.first['user_name'] ?? 'Null'}';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isInstructorLoading(false);
    }
  }
}
