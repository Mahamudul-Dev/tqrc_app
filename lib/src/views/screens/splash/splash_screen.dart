import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/local_storage.dart';
import 'package:tqrc_app/src/utils/app_theme.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  void pageNavigation() async {
    final token = LocalStorage.getData(key: LocalStorageKey.token);
    final tenant = LocalStorage.getData(key: LocalStorageKey.tenant);

    kPrint('Token Value: $token');
    kPrint('Tenant Value: $tenant');

    if (token != null && tenant != null) {
      Get.offAllNamed(RouteGenerator.home);
    } else {
      Get.offAllNamed(RouteGenerator.login);
    }
  }

  Future<bool> getAppInit() async {
    bool value = false;
    FirebaseFirestore.instance
        .collection('app_init')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        kPrint('${doc.data()}');
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        kPrint('app is running: ${data["app_running"] as bool}');
        value = data["app_running"] as bool;
        String title = data["app_title"] as String;
        String body = data["app_body"] as String;

        Timer(const Duration(seconds: 3), () async {
          if (value) {
            pageNavigation();
          } else {
            customDialog(
              context: context,
              title: title,
              content: Text(
                body,
                style: h4.copyWith(
                  color: kGreyTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              dialogPosition: Alignment.center,
              actions: [
                KButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  bgColor: failedColor,
                  child: Text(
                    'Exit App',
                    style: h4.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
              ],
            );
          }
        });
      }
    });
    return value;
  }

  @override
  void initState() {
    /// hide status bar only for splash screen
    AppThemeData.hideStatusBar();

    //get app init
    Future<bool> appIsRunning = getAppInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );

    animation.addListener(() => setState(() {}));
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    /// since we change app status bar so we need to re-enable default settings
    /// then I set dark status bar for all screen
    AppThemeData.enableInitialThemeSetting();
    AppThemeData.setDarkStatusBar();

    /// dispose animation
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KLogo(
          height: animation.value * 150,
          width: animation.value * 150,
        ),
      ),
    );
  }
}
