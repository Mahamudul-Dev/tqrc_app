import 'package:flutter/material.dart';
import 'package:tqrc_app/src/utils/asset_path.dart';
import 'package:tqrc_app/src/utils/color.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class KCustomLoader extends StatelessWidget {
  const KCustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsorbPointer(
        child: Center(
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          AssetPath.logo,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20.0),
                const DefaultTextStyle(
                  style: TextStyle(),
                  child: Text('Please Wait...'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
