import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/activities_controller.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_appbar_with_back.dart';
import 'package:tqrc_app/src/views/base/k_custom_loader.dart';
import 'package:tqrc_app/src/views/base/no_data_found.dart';
import 'package:tqrc_app/src/views/screens/activities/components/activity_item.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final activitiesController = Get.find<ActivitiesController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    activitiesController.refreshActivitiesList();
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
        activitiesController.lastOffset.value = _scrollController.offset;
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          kPrint('reach to bottom');
          if (!activitiesController.loadedCompleted.value) {
            ++activitiesController.pageNumber.value;
            activitiesController.getActivitiesList();
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
            KAppBarWithBack(title: 'Activities'.tr),
            Expanded(
              child: _buildActivitiesBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await activitiesController.refreshActivitiesList();
      },
      child: Obx(() {
        if (activitiesController.isLoading.value) {
          return const KCustomLoader();
        } else {
          if (activitiesController.activitiesList.isEmpty) {
            return const NoDataFound();
          } else {

            /// animate list
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _scrollController.animateTo(
                activitiesController.lastOffset.value,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
            });

            return ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: activitiesController.activitiesList.length + 1,
              itemBuilder: (context, index) {
                if (index == activitiesController.activitiesList.length &&
                    !activitiesController.loadedCompleted.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (index ==
                        activitiesController.activitiesList.length &&
                    activitiesController.loadedCompleted.value) {
                  return Container();
                }
                return ActivityItem(
                  data: activitiesController.activitiesList[index],
                );
              },
              separatorBuilder: (context, index) => addVerticalSpace(
                Dimensions.paddingSizeDefault,
              ),
            );
          }
        }
      }),
    );
  }
}
