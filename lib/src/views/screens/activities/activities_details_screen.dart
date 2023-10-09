import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/controllers/activities_controller.dart';
import 'package:tqrc_app/src/models/activities_data.dart';
import 'package:tqrc_app/src/models/activities_details_data.dart';
import 'package:tqrc_app/src/services/extensions/string_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/k_divider.dart';
import 'package:tqrc_app/src/views/base/k_outlined_button.dart';
import 'package:tqrc_app/src/views/base/k_text_form_field.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';

class ActivitiesDetailsScreen extends StatefulWidget {
  const ActivitiesDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesDetailsScreen> createState() =>
      _ActivitiesDetailsScreenState();
}

class _ActivitiesDetailsScreenState extends State<ActivitiesDetailsScreen> {
  int? isTransportThere;
  int? isTransportBack;
  final remarkTextController = TextEditingController();

  /// received from previous screen
  int? planningID;
  List<ActivityData>? activityData;

  final activitiesController = Get.find<ActivitiesController>();

  @override
  void initState() {
    planningID = Get.arguments[0];
    activityData = Get.arguments[1];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activitiesController.getActivitiesDetails(
        planningID: '$planningID',
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'Activities Details'.tr),
            Expanded(
              child: _buildActivitiesDetailsBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesDetailsBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (activitiesController.isLoading.value) {
        return const KCustomLoader();
      } else if (activitiesController.activitiesDetails.value.id == null) {
        return const NoDataFound();
      } else {
        ActivitiesDetailsData data =
            activitiesController.activitiesDetails.value;
        isTransportThere = data.transportThere;
        isTransportBack = data.transportBack;
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            /// activity content
            Container(
              height: size.height,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.date!.isNotEmpty
                          ? getFullLocaleDate(DateTime.parse(data.date ?? ""))
                          : '',
                      style: h5.copyWith(
                        color: kGreyTextColor,
                      ),
                    ),
                    addVerticalSpace(2),
                    Text(
                      '${data.timeStart!.formatTime} - ${data.timeStop!.formatTime}',
                      style: h5.copyWith(
                        color: kGreyTextColor,
                      ),
                    ),
                    addVerticalSpace(Dimensions.paddingSizeSmall),
                    Text(
                      data.name ?? '',
                      style: h3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    addVerticalSpace(5),
                    Text(
                      data.description ?? '',
                      textAlign: TextAlign.justify,
                      style: h5.copyWith(
                        color: kGreyTextColor,
                      ),
                    ),
                    addVerticalSpace(Dimensions.paddingSizeLarge),
                    _buildExtraInfo(size, data),

                    /// give space from bottom
                    addVerticalSpace(80),
                  ],
                ),
              ),
            ),

            /// signup or withdraw button
            Container(
              alignment: Alignment.center,
              height: 70,
              color: kWhite,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child: activityData!.isNotEmpty
                  ? _buildWidthDrawButton(context, data.id!)
                  : _buildSignupButton(context, data),
            )
          ],
        );
      }
    });
  }

  Widget _buildExtraInfo(Size size, ActivitiesDetailsData data) {
    return Container(
      width: size.width,
      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            spreadRadius: 0,
            color: kItemShadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRowText(
            title: 'Material'.tr,
            value: data.material ?? "",
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Room'.tr,
            value: data.room ?? "",
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Transport'.tr,
            value: data.transport!,
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Transport there'.tr,
            value: data.transportThere!.toString() == '1' ? 'Yes'.tr : 'No'.tr,
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Transport back'.tr,
            value: data.transportBack!.toString() == '1' ? 'Yes'.tr : 'No'.tr,
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Details'.tr,
            value: data.details ?? "",
          ),
          KDivider(color: kGreyMedium),
          _buildRowText(
            title: 'Address'.tr,
            value: data.adres ?? "",
          ),
        ],
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
          addHorizontalSpace(Dimensions.paddingSizeSmall),
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

  Widget _buildSignupButton(BuildContext context, ActivitiesDetailsData data) =>
      KButton(
        onPressed: () => openSignupDialog(context, data),
        bgColor: kBlue,
        child: Text(
          'Signup'.tr,
          style: GoogleFonts.roboto(
            textStyle: h3.copyWith(
              color: kWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Widget _buildWidthDrawButton(BuildContext context, int planningID) => KButton(
        onPressed: () => activitiesController.withDrawActivity(
          planningID: '$planningID',
        ),
        bgColor: kGreen,
        child: activitiesController.isActivityUpdating.value
            ? Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: kWhite,
                ),
              )
            : Text(
                'Withdraw'.tr,
                style: GoogleFonts.roboto(
                  textStyle: h3.copyWith(
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      );

  void openSignupDialog(BuildContext context, ActivitiesDetailsData data) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Obx(() {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                insetPadding: EdgeInsets.all(
                  Dimensions.paddingSizeDefault,
                ),
                alignment: Alignment.bottomCenter,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Text(
                  'Sign Up'.tr,
                  textAlign: TextAlign.center,
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// title, date & time
                      Text(
                        data.name ?? '',
                        style: h5.copyWith(
                          color: kGreyTextColor,
                        ),
                      ),
                      addVerticalSpace(2),
                      Text(
                        data.date!.isNotEmpty
                            ? getFullLocaleDate(DateTime.parse(data.date ?? ""))
                            : '',
                        style: h5.copyWith(
                          color: kGreyTextColor,
                        ),
                      ),
                      addVerticalSpace(2),
                      Text(
                        '${data.timeStart!.formatTime} - ${data.timeStop!.formatTime}',
                        style: h5.copyWith(
                          color: kGreyTextColor,
                        ),
                      ),

                      KDivider(height: 30, color: kGreyTextColor),

                      /// transport there
                      data.transportThere == 0
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transport there'.tr,
                                  style: h3.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: context.width * 0.3,
                                      child: RadioListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        value: 1,
                                        title: Text(
                                          'Yes'.tr,
                                          style: h5.copyWith(
                                            color: kGreyTextColor,
                                          ),
                                        ),
                                        groupValue: isTransportThere,
                                        onChanged: (value) {
                                          setState(() {
                                            isTransportThere = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width * 0.3,
                                      child: RadioListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        value: 0,
                                        title: Text(
                                          'No'.tr,
                                          style: h5.copyWith(
                                            color: kGreyTextColor,
                                          ),
                                        ),
                                        groupValue: isTransportThere,
                                        onChanged: (value) {
                                          setState(() {
                                            isTransportThere = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                      /// transport back
                      data.transportBack == 0
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transport back'.tr,
                                  style: h3.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: context.width * 0.3,
                                      child: RadioListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        value: 1,
                                        title: Text(
                                          'Yes'.tr,
                                          style: h5.copyWith(
                                            color: kGreyTextColor,
                                          ),
                                        ),
                                        groupValue: isTransportBack,
                                        onChanged: (value) {
                                          setState(() {
                                            isTransportBack = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width * 0.3,
                                      child: RadioListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        value: 0,
                                        title: Text(
                                          'No'.tr,
                                          style: h5.copyWith(
                                            color: kGreyTextColor,
                                          ),
                                        ),
                                        groupValue: isTransportBack,
                                        onChanged: (value) {
                                          setState(() {
                                            isTransportBack = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                      addVerticalSpace(Dimensions.paddingSizeExtraSmall),

                      /// remark textField
                      KTextFormFiled(
                        controller: remarkTextController,
                        labelText: 'Remark'.tr,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                      )
                    ],
                  ),
                ),
                actions: [
                  /// close button
                  KOutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    width: MediaQuery.of(context).size.width * 0.4,
                    borderColor: kGrey,
                    child: Text(
                      'Close'.tr,
                      style: h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kGrey,
                      ),
                    ),
                  ),

                  addHorizontalSpace(Dimensions.paddingSizeExtraSmall),

                  /// signup button
                  KButton(
                    onPressed: () {
                      /// define params based on transport value
                      Map<String, dynamic> params = {};
                      if (remarkTextController.text.isNotEmpty) {
                        params['remark'] = remarkTextController.text;
                      }

                      if (data.transport == '0') {
                        params['planning_id'] = '$planningID';
                        params['activityType'] = 'regular';
                      } else {
                        params['planning_id'] = '$planningID';
                        params['activityType'] = 'regular';
                        params['transport_there'] = '$isTransportThere';
                        params['transport_back'] = '$isTransportBack';
                      }

                      /// call signup api
                      activitiesController.signupActivity(params: params);
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: activitiesController.isActivityUpdating.value
                        ? Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: kWhite,
                            ),
                          )
                        : Text(
                            'Sign Up'.tr,
                            style: GoogleFonts.roboto(
                              textStyle: h3.copyWith(
                                color: kWhite,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }
}
