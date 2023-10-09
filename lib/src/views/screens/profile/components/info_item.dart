import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/utils/dimensions.dart';
import 'package:tqrc_app/src/utils/styles.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class ProfileInfoItem extends StatelessWidget {
  final String title;
  final String data;
  final VoidCallback? onPressed;
  final bool isEditable;

  const ProfileInfoItem({
    Key? key,
    required this.title,
    required this.data,
    this.onPressed,
    required this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: h4,
          ),
        ),
        const Spacer(),
        isEditable
            ? GestureDetector(
                onTap: onPressed,
                child: Row(
                  children: [
                    Text(
                      data,
                      style: GoogleFonts.roboto(
                        textStyle: h5.copyWith(
                          color: kGrey,
                        ),
                      ),
                    ),
                    addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
                    Icon(
                      Icons.edit,
                      color: kGrey,
                      size: 10,
                    ),
                  ],
                ),
              )
            : Text(
                data,
                style: GoogleFonts.roboto(
                  textStyle: h5.copyWith(
                    color: kGrey,
                  ),
                ),
              ),
      ],
    );
  }
}
