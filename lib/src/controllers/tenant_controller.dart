import 'package:get/get.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/network/network_utils.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class TenantController extends GetxController{
  var isLoading = false.obs;
  var tenantList = <String>[].obs;

  @override
  void onInit() {
    getTenantList();
    super.onInit();
  }

  Future<void> getTenantList() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(endPoint: Api.tenantList),
      );

      if (responseBody != null) {
        tenantList.value = [];
        for(var tenant in responseBody){
          tenantList.add(tenant);
        }
      } else {
        throw 'Unable to load tenant list!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}