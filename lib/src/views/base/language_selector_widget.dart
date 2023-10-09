import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/localization/app_localization.dart';
import 'package:tqrc_app/src/controllers/locale_controller.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';


class LanguageSelectorWidget extends StatelessWidget {
  LanguageSelectorWidget({Key? key}) : super(key: key);
  final localeController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => openLanguageSelectorDialog(context),
        child: Row(
          children: [
            Text(
              'Language',
              style: GoogleFonts.roboto(
                textStyle: h4,
              ),
            ),
            const Spacer(),
            Text(
              localeController.selectedLocaleData.value.languageCode,
              style: h3.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            addHorizontalSpace(Dimensions.paddingSizeSmall),
            Image.asset(
              localeController.selectedLocaleData.value.flag,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
            addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
            const Icon(Icons.arrow_forward_ios_outlined, size: 15,)
          ],
        ),
      );
    });
  }

  openLanguageSelectorDialog(BuildContext context) {
    customDialog(
      context: context,
      title: "Select your language".tr,
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalization.locals[0].languageName),
                  Image.asset(
                    AppLocalization.locals[0].flag,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              value: AppLocalization.locals[0],
              groupValue: localeController.selectedLocaleData.value,
              onChanged: (value) {
                if (value != null) {
                  localeController.updateLocale(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalization.locals[1].languageName),
                  Image.asset(
                    AppLocalization.locals[1].flag,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              value: AppLocalization.locals[1],
              groupValue: localeController.selectedLocaleData.value,
              onChanged: (value) {
                if (value != null) {
                  localeController.updateLocale(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      }),
      dialogPosition: Alignment.bottomCenter,
    );
  }
}
