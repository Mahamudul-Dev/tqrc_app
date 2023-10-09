import 'package:get/get.dart';
import 'package:tqrc_app/localization/app_localization.dart';
import 'package:tqrc_app/src/models/locale_data.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/local_storage.dart';

class LocaleController extends GetxController {
  var selectedLocaleData = AppLocalization.locals.first.obs;

  @override
  void onInit() {
    setInitialLocale();
    super.onInit();
  }

  setInitialLocale() {
    var languageCode = LocalStorage.getData(
      key: LocalStorageKey.localeLanguageCode,
    );

    if (languageCode != null) {
      for (var localData in AppLocalization.locals) {
        if(localData.locale.languageCode == languageCode){
          selectedLocaleData.value = localData;
        }
      }
    }
  }

  updateLocale(LocaleData localeData) {
    selectedLocaleData.value = localeData;
    Get.updateLocale(selectedLocaleData.value.locale);

    /// to save in local storage
    LocalStorage.saveData(
      key: LocalStorageKey.localeLanguageCode,
      data: selectedLocaleData.value.locale.languageCode,
    );
  }
}
