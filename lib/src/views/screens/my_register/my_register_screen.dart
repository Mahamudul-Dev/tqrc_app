import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/my_register_controller.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';
import 'package:tqrc_app/src/views/screens/my_register/components/my_register_item_builder.dart';

class MyRegisterScreen extends StatefulWidget {
  const MyRegisterScreen({Key? key}) : super(key: key);

  @override
  State<MyRegisterScreen> createState() => _MyRegisterScreenState();
}

class _MyRegisterScreenState extends State<MyRegisterScreen> {
  final myRegisterController = Get.find<MyRegisterController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    myRegisterController.refreshMyRegisterList();
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
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          kPrint('reach to bottom');
          if (!myRegisterController.loadedCompleted.value) {
            ++myRegisterController.pageNumber.value;
            myRegisterController.getMyRegisterList();
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
            KAppBarWithBack(title: 'My Register'.tr),
            Expanded(
              child: _buildMyRegisterBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRegisterBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await myRegisterController.refreshMyRegisterList();
      },
      child: Obx(() {
        if (myRegisterController.isLoading.value) {
          return const KCustomLoader();
        } else if (myRegisterController.myRegisterDataList.isEmpty) {
          return const NoDataFound();
        } else {
          return ListView.separated(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: myRegisterController.myRegisterDataList.length + 1,
            itemBuilder: (context, index) {
              if (index == myRegisterController.myRegisterDataList.length &&
                  !myRegisterController.loadedCompleted.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (index ==
                      myRegisterController.myRegisterDataList.length &&
                  myRegisterController.loadedCompleted.value) {
                return Container();
              }

              return MyRegisterItemBuilder(
                data: myRegisterController.myRegisterDataList[index],
              );
            },
            separatorBuilder: (context, index) => addVerticalSpace(
              Dimensions.paddingSizeDefault,
            ),
          );
        }
      }),
    );
  }
}
