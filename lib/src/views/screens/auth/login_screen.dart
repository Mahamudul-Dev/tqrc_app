import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/controllers/auth_controller.dart';
import 'package:tqrc_app/src/controllers/tenant_controller.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/extensions/build_context_extension.dart';
import 'package:tqrc_app/src/services/local_storage.dart';
import 'package:tqrc_app/src/utils/app_constants.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/messages.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/k_logo.dart';
import 'package:tqrc_app/src/views/base/k_text_form_field.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();
  final tenantController = Get.find<TenantController>();
  String? selectedTenant;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool passwordVisibility = true;
  final _loginFormKey = GlobalKey<FormState>();

  var deviceTokenToSendPushNotification = '';

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    kPrint("Token Value >>> $deviceTokenToSendPushNotification    <<complete");
  }

  @override
  void initState() {
    getDeviceTokenToSendNotification();
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
          ),
          child: Obx(() {
            return tenantController.isLoading.value
                ? const KCustomLoader()
                : tenantController.tenantList.isEmpty
                    ? const NoDataFound()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),

                              /// logo and loginWithPassword text
                              const KLogo(),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Login To'.tr,
                                    style: h2.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${AppConstants.appName}",
                                    style: h2.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: mainColor,
                                    ),
                                  ),
                                ]),
                              ),

                              /// tenant dropdown
                              addVerticalSpace(Get.height * 0.04),
                              _buildTenantDropDown(),

                              /// email textField
                              addVerticalSpace(Get.height * 0.02),
                              _buildEmailTextFiled(),

                              /// password textField
                              addVerticalSpace(Get.height * 0.02),
                              _buildPasswordTextFiled(),

                              /// login button
                              addVerticalSpace(Get.height * 0.05),
                              _buildLoginButton(context),

                              addVerticalSpace(Get.height * 0.03),
                            ],
                          ),
                        ),
                      );
          }),
        ),
      ),
    );
  }

  Widget _buildTenantDropDown() => DropdownButtonFormField(
        // isDense: true,
        validator: (value) {
          if (selectedTenant == null) {
            return Message.emptyTenant;
          }
          return null;
        },
        isExpanded: true,
        items: tenantController.tenantList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: h4,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedTenant = value;
            LocalStorage.saveData(
              key: LocalStorageKey.tenant,
              data: selectedTenant,
            );
          });
        },
        hint: Text(
          'Select Tenant'.tr,
          style: h4.copyWith(
            color: kGreyTextColor,
          ),
        ),
        value: selectedTenant,
      );

  Widget _buildEmailTextFiled() => KTextFormFiled(
        controller: emailTextController,
        labelText: 'Email'.tr,
        inputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress,
        validator: (value) {
          if (value.toString().isEmpty) {
            return Message.emptyEmail.tr;
          }
          return null;
        },
      );

  Widget _buildPasswordTextFiled() => KTextFormFiled(
        controller: passwordTextController,
        labelText: 'Password'.tr,
        inputAction: TextInputAction.done,
        inputType: TextInputType.visiblePassword,
        obscureValue: passwordVisibility,
        suffix: GestureDetector(
          onTap: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
          child: Icon(
            passwordVisibility ? Icons.visibility_off : Icons.visibility,
            color: kBlackLight,
          ),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            return Message.emptyPassword.tr;
          } else if (value.toString().length < 6) {
            return Message.invalidPassword.tr;
          }
          return null;
        },
      );

  Widget _buildLoginButton(BuildContext context) => KButton(
        onPressed: () => _loginMethod(context),
        child: authController.isLoading.value
            ? Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: kWhite,
                ),
              )
            : Text(
                'Login'.tr,
                style: GoogleFonts.roboto(
                  textStyle: h3.copyWith(
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      );

  void _loginMethod(BuildContext context) {
    context.unFocusKeyboard();
    if (_loginFormKey.currentState!.validate()) {
      authController.login(
        deviceToken: deviceTokenToSendPushNotification,
        tenant: selectedTenant ?? "",
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    }
  }
}
