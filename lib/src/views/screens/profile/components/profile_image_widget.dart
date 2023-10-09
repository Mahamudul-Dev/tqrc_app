import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrc_app/src/controllers/auth_controller.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/services/image_services.dart';

import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';
import 'package:tqrc_app/src/views/base/k_outlined_button.dart';
import 'package:tqrc_app/src/views/base/k_profile_image.dart';

class ProfileImageWidget extends StatelessWidget {
  final AuthController authController;

  const ProfileImageWidget({
    Key? key,
    required this.authController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          KProfileImage(
            height: 115,
            width: 115,
            imgURL: Api.getImageURL(authController.userInfo.value.img),
          ),
          Positioned(
            child: Container(
              width: 115,
              height: 115,
              padding: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    kGrey,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: GestureDetector(
                onTap: () => openImageSourceSelectorDialog(context),
                child: Icon(
                  Icons.camera_alt,
                  color: kWhite,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  void openImageSourceSelectorDialog(BuildContext context) {
    customDialog(
      context: context,
      title: "Choose an image from".tr,
      dialogPosition: Alignment.bottomCenter,
      barrierDismissible: true,
      actions: [
        /// image from camera
        KOutlinedButton(
          onPressed: () async {
            final img = await ImageServices.cameraImage();
            var imageFile = await ImageServices.getImageFile(img);
            authController.changeProfile(
              filepath: ImageServices.getImagePath(imageFile!),
            ).then((value){
              Navigator.pop(context);
            });
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: mainColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: mainColor,
              ),
              addHorizontalSpace(Dimensions.paddingSizeSmall),
              Text(
                'Camera'.tr,
                style: h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),

        /// image from gallery
        KOutlinedButton(
          onPressed: () async {
            final img = await ImageServices.galleryImage();
            var imageFile = await ImageServices.getImageFile(img);
            authController.changeProfile(
              filepath: ImageServices.getImagePath(imageFile!),
            ).then((value){
              Navigator.pop(context);
            });
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: mainColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: mainColor,
              ),
              addHorizontalSpace(Dimensions.paddingSizeSmall),
              Text(
                'Gallery'.tr,
                style: h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
