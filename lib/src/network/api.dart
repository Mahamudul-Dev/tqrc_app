import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/local_storage.dart';

class Api{
  /// api config
  static const String _protocol = "https://";
  static const String _domain = "webelix.nl/";
  static const String _apiEndPath = "api/";

  static const String baseUrl = '$_protocol$_domain$_apiEndPath';

  static String getImageURL(endPoint) => 'https://webelix.nl/${LocalStorage.getData(key: LocalStorageKey.tenant)}/tenancy/assets/$endPoint';

  /// endpoints
  static String get tenantList => 'tenant-list';
  static String get login => 'tenant-login';
  static String get logout => 'logout';
  static String get userInfo => 'user-info';
  static String get changeProfile => 'changeProfile';
  static String get announcementList => 'tenant-announcememnt';
  static String get activitiesList => 'activities';
  static String get activitiesDetails => 'activity-details';
  static String get withdraw => 'withdraw';
  static String get signup => 'store-activities';
  static String get myRegister => 'my_register';
  static String get getRegisterInstructor => 'confirm-user';
  static String get datePickerList => 'datepicker_list';
  static String get notificationList => 'list-notification';
  static String get updateNotificationStatus => 'seen-notification';
 }