import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/activities_controller.dart';
import 'package:tqrc_app/src/controllers/announcement_controller.dart';
import 'package:tqrc_app/src/controllers/auth_controller.dart';
import 'package:tqrc_app/src/controllers/date_picker_controller.dart';
import 'package:tqrc_app/src/controllers/my_register_controller.dart';
import 'package:tqrc_app/src/controllers/notification_controller.dart';
import 'package:tqrc_app/src/controllers/tenant_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TenantController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => AnnouncementController(), fenix: true);
    Get.lazyPut(() => ActivitiesController(), fenix: true);
    Get.lazyPut(() => DatePickerController(), fenix: true);
    Get.lazyPut(() => MyRegisterController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }

}