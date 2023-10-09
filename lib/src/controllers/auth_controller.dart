import 'package:get/get.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/models/user_data.dart';
import 'package:tqrc_app/src/models/user_info.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/local_storage.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isFetchingUserData = false.obs;
  Rx<UserData> userData = UserData().obs;
  Rx<UserInfo> userInfo = UserInfo().obs;

  Future login({
    required String deviceToken,
    required String tenant,
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      var map = <String, dynamic>{};
      map['device_id'] = deviceToken;
      map['tenant'] = tenant;
      map['email'] = email;
      map['password'] = password;

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          endPoint: Api.login,
          body: map,
        ),
      );

      if (responseBody != null) {
        kSnackBar(message: 'Logged in Successfully!', bgColor: successColor);
        userData.value = UserData.fromJson(responseBody);
        LocalStorage.saveData(
          key: LocalStorageKey.token,
          data: userData.value.token,
        );
        Get.offAllNamed(RouteGenerator.home);
      } else {
        throw 'Logged in Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future logout() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.logout,
        ),
      );

      if (responseBody != null) {
        LocalStorage.removeData(key: LocalStorageKey.token);
        LocalStorage.removeData(key: LocalStorageKey.tenant);
        kSnackBar(message: 'Logout Successfully!', bgColor: successColor);
        Get.offAllNamed(RouteGenerator.login);
      } else {
        kSnackBar(message: 'Logout Failed!', bgColor: failedColor);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future getUserData() async {
    try {
      isFetchingUserData(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          endPoint: Api.userInfo,
        ),
      );

      if (responseBody != null) {
        userInfo.value = UserInfo.fromJson(responseBody);
      } else {
        throw 'Failed To Load User!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isFetchingUserData(false);
    }
  }

  Future changeProfile({
    String? filepath,
  }) async {
    try {
      // isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.multipartAddRequest(
          endPoint: Api.changeProfile,
          body: {},
          fileKeyName: 'images',
          filePath: filepath ?? "",
        ),
      );

      if (responseBody != null) {
        kSnackBar(
          message: responseBody['message'] ?? 'Your Profile Updated!',
          bgColor: successColor,
        );

        /// reload user data
        getUserData();
      } else {
        throw 'Failed To update user profile!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      // isLoading(false);
    }
  }
}
