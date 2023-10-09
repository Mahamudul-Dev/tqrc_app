import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/date_picker_controller.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';
import 'package:tqrc_app/src/views/screens/date_picker/components/date_picker_item.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  final datePickerController = Get.find<DatePickerController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    datePickerController.refreshDatePickerList();
    scrollIndicator();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollIndicator() {
    _scrollController.addListener(
      () {
        datePickerController.lastOffset.value = _scrollController.offset;
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          kPrint('reach to bottom');
          if (!datePickerController.loadedCompleted.value) {
            ++datePickerController.pageNumber.value;
            datePickerController.getDatePickerList();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KAppBarWithBack(title: 'Date Picker'.tr),
            Expanded(
              child: _buildDatePickerBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await datePickerController.refreshDatePickerList();
      },
      child: Obx(
        () {
          if (datePickerController.isLoading.value) {
            return const KCustomLoader();
          } else {
            if (datePickerController.datePickerList.isEmpty) {
              return const NoDataFound();
            } else {

              /// animate list
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _scrollController.animateTo(
                  datePickerController.lastOffset.value,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              });

              return ListView.separated(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: datePickerController.datePickerList.length + 1,
                itemBuilder: (context, index) {
                  if (index == datePickerController.datePickerList.length &&
                      !datePickerController.loadedCompleted.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (index ==
                          datePickerController.datePickerList.length &&
                      datePickerController.loadedCompleted.value) {
                    return Container();
                  }
                  return DatePickerItem(
                    data: datePickerController.datePickerList[index],
                  );
                },
                separatorBuilder: (context, index) => addVerticalSpace(
                  Dimensions.paddingSizeDefault,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
