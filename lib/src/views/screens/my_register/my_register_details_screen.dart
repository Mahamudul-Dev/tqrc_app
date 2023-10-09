import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/controllers/my_register_controller.dart';
import 'package:tqrc_app/src/models/my_register_data.dart';
import 'package:tqrc_app/src/services/extensions/string_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_divider.dart';

class MyRegisterDetailsScreen extends StatefulWidget {
  const MyRegisterDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MyRegisterDetailsScreen> createState() =>
      _MyRegisterDetailsScreenState();
}

class _MyRegisterDetailsScreenState extends State<MyRegisterDetailsScreen> {
  MyRegisterData? data;
  final myRegisterController = Get.find<MyRegisterController>();

  @override
  void initState() {
    /// received data from my register screen
    data = Get.arguments;
    myRegisterController.getRegisterInstructor(
      planningId: data!.planningId!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'My Register Details'.tr),
            Expanded(
              child: _buildMyRegisterBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRegisterBody() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildRowText(
              title: 'Name'.tr,
              value: data?.name ?? "...",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Compensation Amount'.tr,
              value: '€ ${data?.compensationAmount ?? 0}',
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Time'.tr,
              value:
                  '${data?.timeStart!.formatTime} - ${data?.timeStop!.formatTime}',
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Date'.tr,
              value: data!.date!.isNotEmpty
                  ? getFullLocaleDate(DateTime.parse(data?.date ?? ""))
                  : '',
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Remark'.tr,
              value: data?.remark ?? "...",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Status'.tr,
              value: data?.status ?? "...",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Material'.tr,
              value: data?.material ?? "",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Room'.tr,
              value: data?.room ?? "",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Transport'.tr,
              value: data!.transport!,
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Transport there'.tr,
              value:
                  data?.transportThere!.toString() == '1' ? 'Yes'.tr : 'No'.tr,
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Transport back'.tr,
              value:
                  data?.transportBack!.toString() == '1' ? 'Yes'.tr : 'No'.tr,
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Details'.tr,
              value: data?.details ?? "...",
            ),
            KDivider(color: kGreyMedium),
            _buildRowText(
              title: 'Address'.tr,
              value: data?.adres ?? "...",
            ),
            KDivider(color: kGreyMedium),
            Obx(
              () {
                if (myRegisterController.isInstructorLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return _buildRowText(
                    title: 'Instructor'.tr,
                    value: myRegisterController.registerInstructor.value,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowText({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                textStyle: h4,
              ),
            ),
          ),
          addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.roboto(
                textStyle: h5.copyWith(
                  color: kGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
