import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tqrc_app/di/app_bindings.dart';
import 'package:tqrc_app/localization/app_localization.dart';
import 'package:tqrc_app/src/controllers/locale_controller.dart';
import 'package:tqrc_app/src/services/firebase_push_notification_services.dart';
import 'package:tqrc_app/src/services/local_notification_services.dart';
import 'package:tqrc_app/src/utils/app_constants.dart';
import 'package:tqrc_app/src/utils/app_theme.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

import 'routes/routes.dart';
import 'src/views/base/k_scroll_behavior.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  kPrint(message.data.toString());
  kPrint(message.notification!.title);
}

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await initializeDateFormatting('en_US');
  await initializeDateFormatting('nl_NL');

  await Firebase.initializeApp();
  LocalNotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebasePushNotificationServices().handleNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localController = Get.put(LocaleController());
    return Obx(() {
      return GetMaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: KScrollBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppThemeData.lightTheme,
        initialRoute: RouteGenerator.splash,
        getPages: RouteGenerator.routes,
        initialBinding: AppBindings(),

        /// localization
        translations: AppLocalization(),
        locale: localController.selectedLocaleData.value.locale,
        fallbackLocale: AppLocalization.locals.first.locale,
      );
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
