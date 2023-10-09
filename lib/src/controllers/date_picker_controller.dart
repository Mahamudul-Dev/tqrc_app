import 'package:get/get.dart';
import 'package:tqrc_app/src/models/date_picker_data.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class DatePickerController extends GetxController {
  var isLoading = false.obs;
  var isDatePickerUpdating = false.obs;
  var datePickerList = <DatePickerData>[].obs;
  var pageNumber = 1.obs;
  var loadedCompleted = false.obs;
  var lastOffset = 0.0.obs;

  Future<void> refreshDatePickerList()async{
    pageNumber.value = 1;
    await getDatePickerList();
  }

  Future<void> getDatePickerList() async {
    try {
      if (pageNumber.value == 1) {
        datePickerList.value = [];
        isLoading(true);
        loadedCompleted(false);
      }

      var param = <String, dynamic>{};
      param['page'] = pageNumber.value.toString();
      param['perPage'] = "10";

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.datePickerList,
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
            datePickerList.add(DatePickerData.fromJson(i));
          }
        }
      } else {
        throw 'Unable to load date picker list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshDatePickerListAfterUpdate() async {
    try {
      int lastPageNumber = pageNumber.value;

      for(int i = 1; i <= lastPageNumber; i++){
        pageNumber.value = i;
        if (pageNumber.value == 1) {
          datePickerList.value = [];
          isLoading(true);
          loadedCompleted(false);
        }

        var param = <String, dynamic>{};
        param['page'] = pageNumber.value.toString();
        param['perPage'] = "10";

        dynamic responseBody = await Network.handleResponse(
          await Network.getRequest(
            endPoint: Api.datePickerList,
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
              datePickerList.add(DatePickerData.fromJson(i));
            }
          }
        } else {
          throw 'Unable to load date picker list!';
        }
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> withDrawDatePicker({required String planningID}) async {
    try {
      isDatePickerUpdating(true);

      final params = <String, dynamic>{
        'planning_id': planningID,
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.withdraw,
          params: params,
        ),
      );

      if (responseBody != null) {
        kSnackBar(message: 'Withdraw Successfully!', bgColor: successColor);
        await refreshDatePickerListAfterUpdate();
      } else {
        throw 'Withdraw Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isDatePickerUpdating(false);
    }
  }

  Future<void> signupDatePicker({required Map<String, dynamic> params}) async {
    try {
      isDatePickerUpdating(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.signup,
          params: params,
        ),
      );

      if (responseBody != null) {
        kSnackBar(message: 'Signup Successfully!', bgColor: successColor);
        await refreshDatePickerListAfterUpdate();
      } else {
        throw 'Signup Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isDatePickerUpdating(false);
    }
  }
}
