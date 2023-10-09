import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/utils/asset_path.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class KProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String imgURL;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const KProfileImage({
    Key? key,
    required this.height,
    required this.width,
    required this.imgURL,
    this.borderColor,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    kPrint('Image Url: $imgURL');
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? kGreyMedium,
        ),
      ),
      child: imgURL.isEmpty || imgURL == Api.getImageURL('')
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                AssetPath.people,
                fit: BoxFit.cover,
              ),
            )
          : CachedNetworkImage(
              imageUrl: imgURL,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kBlackLight.withOpacity(0.2),
                      offset: const Offset(0.0, 3.0),
                      blurRadius: 5,
                    )
                  ],
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              fit: BoxFit.cover,
              placeholder: (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  AssetPath.placeholder,
                  fit: BoxFit.cover,
                ),
              ),
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  AssetPath.people,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
