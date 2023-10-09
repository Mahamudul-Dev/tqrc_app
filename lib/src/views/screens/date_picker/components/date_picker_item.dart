import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tqrc_app/src/controllers/date_picker_controller.dart';
import 'package:tqrc_app/src/models/date_picker_data.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/extensions/string_extension.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_button.dart';
import 'package:tqrc_app/src/views/base/k_outlined_button.dart';
import 'package:tqrc_app/src/views/base/k_text_form_field.dart';

class DatePickerItem extends StatefulWidget {
  final DatePickerData data;

  const DatePickerItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DatePickerItem> createState() => _DatePickerItemState();
}

class _DatePickerItemState extends State<DatePickerItem> {
  /// date picker controller
  final datePickerController = Get.find<DatePickerController>();

  String? selectedStatus;
  final remarkTextController = TextEditingController();
  FocusNode remarkFocusNode = FocusNode();

  @override
  void initState() {
    if (widget.data.activityData!.isEmpty) {
      selectedStatus = 'register';
    } else {
      remarkTextController.text = widget.data.activityData!.first.remark ?? '';
      selectedStatus = widget.data.activityData!.first.status ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeDefault,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: kItemShadowColor,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.data.date!.isNotEmpty
                      ? getShortLocaleDate(DateTime.parse(widget.data.date ?? ""))
                      : '',
                  style: h3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(2),
                Text(
                  '${widget.data.timeStart!.formatTime} - ${widget.data.timeStop!.formatTime}',
                  maxLines: 1,
                  style: h5.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(Dimensions.paddingSizeExtraSmall),
                Text(
                  widget.data.name ?? '',
                  style: h5.copyWith(
                    color: kGreyTextColor,
                  ),
                ),
                _buildRemarkText(),
              ],
            ),
          ),
          addHorizontalSpace(Dimensions.paddingSizeSmall),
          PopupMenuButton<String>(
            itemBuilder: (_) {
              return [
                PopupMenuItem<String>(
                  value: DatePickerStatus.available.name,
                  child: Text("Available".tr),
                ),
                PopupMenuItem<String>(
                  value: DatePickerStatus.notavailable.name,
                  child: Text("Not Available".tr),
                ),
                PopupMenuItem<String>(
                  value: DatePickerStatus.unknown.name,
                  child: Text("Maybe Available".tr),
                ),
                PopupMenuItem<String>(
                  value: DatePickerStatus.register.name,
                  child: Text("Clear Choice".tr),
                ),
              ];
            },
            onSelected: (value) async {
              if (value != selectedStatus) {
                if (value == DatePickerStatus.register.name) {
                  withDrawDatePickerMethod();
                } else {
                  await openSignUpDialog(context, value);
                }
              }
            },
            child: Container(
              height: 40,
              width: 140,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraSmall,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatus == DatePickerStatus.available.name
                    ? kGreen
                    : selectedStatus == DatePickerStatus.notavailable.name
                        ? kDeepRed
                        : selectedStatus == DatePickerStatus.unknown.name
                            ? kOrange
                            : mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      selectedStatus == DatePickerStatus.unknown.name
                          ? 'Maybe'.tr
                          : selectedStatus!.capitalizeFirst!.tr,
                      textAlign: TextAlign.center,
                      style: h5.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kWhite,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: kWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemarkText() {
    if (widget.data.activityData!.isNotEmpty) {
      if (widget.data.activityData!.first.remark != '') {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              '${'Remark'.tr}: ${widget.data.activityData!.first.remark}',
              style: h5.copyWith(
                color: kGreyTextColor,
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Future<bool> openSignUpDialog(BuildContext context, String value) async {
    remarkFocusNode = FocusNode();
    remarkFocusNode.requestFocus();
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// title, date & time
                  Text(
                    widget.data.name ?? '',
                    style: h5.copyWith(
                      color: kGreyTextColor,
                    ),
                  ),
                  addVerticalSpace(2),
                  Text(
                    widget.data.date!.isNotEmpty
                        ? getFullLocaleDate(DateTime.parse(widget.data.date ?? ""))
                        : '',
                    style: h5.copyWith(
                      color: kGreyTextColor,
                    ),
                  ),
                  addVerticalSpace(2),
                  Text(
                    '${widget.data.timeStart!.formatTime} - ${widget.data.timeStop!.formatTime}',
                    style: h5.copyWith(
                      color: kGreyTextColor,
                    ),
                  ),

                  addVerticalSpace(Dimensions.paddingSizeLarge),

                  /// remark textField
                  KTextFormFiled(
                    controller: remarkTextController,
                    focusNode: remarkFocusNode,
                    labelText: 'Remark'.tr,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                  )
                ],
              ),
              actions: [
                /// close button
                KOutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
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
                Obx(() {
                  return KButton(
                    onPressed: () {
                      signUpDatePickerMethod(value);
                      Navigator.pop(context, true);
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: datePickerController.isDatePickerUpdating.value
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
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }

  void withDrawDatePickerMethod() async {
    await datePickerController.withDrawDatePicker(
      planningID: '${widget.data.id}',
    );
  }

  void signUpDatePickerMethod(String statusType) async {
    Map<String, dynamic> params = {};

    if (remarkTextController.text.isNotEmpty) {
      params['remark'] = remarkTextController.text;
    }

    params['planning_id'] = '${widget.data.id}';
    params['activityType'] = 'datepicker';
    params['statusType'] = statusType;

    /// call signup api
    await datePickerController.signupDatePicker(params: params);
  }
}
