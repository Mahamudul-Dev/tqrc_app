import 'package:get/get.dart';
import 'package:tqrc_app/src/models/activities_data.dart';
import 'package:tqrc_app/src/models/activities_details_data.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class ActivitiesController extends GetxController {
  var isLoading = false.obs;
  var isActivityUpdating = false.obs;
  var activitiesList = <ActivitiesData>[].obs;
  var activitiesDetails = ActivitiesDetailsData().obs;
  var pageNumber = 1.obs;
  var loadedCompleted = false.obs;
  var lastOffset = 0.0.obs;

  Future<void> refreshActivitiesList()async{
    pageNumber.value = 1;
    await getActivitiesList();
  }

  Future<void> getActivitiesList() async {
    try {
      if (pageNumber.value == 1) {
        activitiesList.value = [];
        isLoading(true);
        loadedCompleted(false);
      }

      var param = <String, dynamic>{};
      param['page'] = pageNumber.value.toString();
      param['perPage'] = "10";

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.activitiesList,
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
            activitiesList.add(ActivitiesData.fromJson(i));
          }
        }
      } else {
        throw 'Unable to load activities list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshActivitiesListAfterUpdate() async {
    try {
      int lastPageNumber = pageNumber.value;

      for(int i = 1; i <= lastPageNumber; i++){
        pageNumber.value = i;
        if (pageNumber.value == 1) {
          activitiesList.value = [];
          isLoading(true);
          loadedCompleted(false);
        }

        var param = <String, dynamic>{};
        param['page'] = pageNumber.value.toString();
        param['perPage'] = "10";

        dynamic responseBody = await Network.handleResponse(
          await Network.getRequest(
            endPoint: Api.activitiesList,
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
              activitiesList.add(ActivitiesData.fromJson(i));
            }
          }
        } else {
          throw 'Unable to load activities list!';
        }
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getActivitiesDetails({required String planningID}) async {
    try {
      isLoading(true);

      final params = <String, dynamic>{
        'planning_id': planningID,
      };

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.activitiesDetails,
          params: params,
        ),
      );

      if (responseBody != null) {
        activitiesDetails.value = ActivitiesDetailsData.fromJson(responseBody);
      } else {
        throw 'Unable to load activities details list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future<void> withDrawActivity({required String planningID}) async {
    try {
      isActivityUpdating(true);

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
        Get.back();
        kSnackBar(message: 'Withdraw Successfully!', bgColor: successColor);
        await refreshActivitiesListAfterUpdate();
      } else {
        throw 'Withdraw Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isActivityUpdating(false);
    }
  }

  Future<void> signupActivity({required Map<String, dynamic> params}) async {
    try {
      isActivityUpdating(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.signup,
          params: params,
        ),
      );

      if (responseBody != null) {
        Get
          ..back()
          ..back();
        kSnackBar(message: 'Signup Successfully!', bgColor: successColor);
        await refreshActivitiesListAfterUpdate();
      } else {
        throw 'Signup Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isActivityUpdating(false);
    }
  }
}
