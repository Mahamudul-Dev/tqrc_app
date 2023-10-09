import 'package:get/get.dart';
import 'package:tqrc_app/src/views/screens/activities/activities_details_screen.dart';
import 'package:tqrc_app/src/views/screens/activities/activities_screen.dart';
import 'package:tqrc_app/src/views/screens/announcement/announcement_details_screen.dart';
import 'package:tqrc_app/src/views/screens/announcement/announcement_screen.dart';
import 'package:tqrc_app/src/views/screens/auth/login_screen.dart';
import 'package:tqrc_app/src/views/screens/date_picker/date_picker_screen.dart';
import 'package:tqrc_app/src/views/screens/home/home_screen.dart';
import 'package:tqrc_app/src/views/screens/my_register/my_register_details_screen.dart';
import 'package:tqrc_app/src/views/screens/my_register/my_register_screen.dart';
import 'package:tqrc_app/src/views/screens/notifications/notification_screen.dart';
import 'package:tqrc_app/src/views/screens/profile/profile_screen.dart';

import '../src/views/screens/splash/splash_screen.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String announcement = '/announcement';
  static const String announcementDetails = '/announcementDetails';
  static const String activities = '/activities';
  static const String activitiesDetails = '/activitiesDetails';
  static const String datePicker = '/datePicker';
  static const String myRegister = '/myRegister';
  static const String myRegisterDetails = '/myRegisterDetails';
  static const String profile = '/profile';
  static const String notifications = '/notifications';

  static final routes = [
    GetPage(
      name: RouteGenerator.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteGenerator.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RouteGenerator.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RouteGenerator.announcement,
      page: () => AnnouncementScreen(),
    ),
    GetPage(
      name: RouteGenerator.announcementDetails,
      page: () => const AnnouncementDetailsScreen(),
    ),
    GetPage(
      name: RouteGenerator.activities,
      page: () => ActivitiesScreen(),
    ),
    GetPage(
      name: RouteGenerator.activitiesDetails,
      page: () => const ActivitiesDetailsScreen(),
    ),
    GetPage(
      name: RouteGenerator.datePicker,
      page: () => DatePickerScreen(),
    ),
    GetPage(
      name: RouteGenerator.myRegister,
      page: () => MyRegisterScreen(),
    ),
    GetPage(
      name: RouteGenerator.myRegisterDetails,
      page: () => const MyRegisterDetailsScreen(),
    ),
    GetPage(
      name: RouteGenerator.profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: RouteGenerator.notifications,
      page: () => NotificationScreen(),
    ),
  ];
}
