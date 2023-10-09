extension DateTimeExtension on DateTime{
  String get yyyyMMddWithSlash {
    return "$year/$month/$day";
  }
}