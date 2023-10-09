// import 'package:barber_shop/src/utils/color.dart';
// import 'package:barber_shop/src/views/base/helper.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LauncherServices {
//   static void makeCall(String number) async {
//     var url = Uri.parse('tel: $number');
//
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       kSnackBar(message: 'Could not make call!', bgColor: failedColor);
//     }
//   }
//
//   static void openURL(String url) async {
//     var uri = Uri.parse(url);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//     } else {
//       kSnackBar(message: 'Could not launch url!', bgColor: failedColor);
//     }
//   }
//
//   static Future<void> openMap(double latitude, double longitude) async {
//     final Uri googleUrl =
//         Uri.parse("google.navigation:q=$latitude,$longitude&mode=d");
//     if (await canLaunchUrl(googleUrl)) {
//       await launchUrl(googleUrl);
//     } else {
//       kSnackBar(message: 'Could not open the map!', bgColor: failedColor);
//     }
//   }
// }
