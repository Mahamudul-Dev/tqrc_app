import 'package:intl/intl.dart';

extension StringExtension on String {
  String get capitalizedFirst {
    if (isEmpty) return '';
    String string = trim();
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  String get minuteAndSecond {
    if (isEmpty) return '';
    String string = trim();
    return string.substring(0, 5);
  }

  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
  }

  String get formatTime {
    String string = trim();
    if (string.isEmpty || string == '' || string == 'null') return '';
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('h:mm');
    DateTime dateTime = inputFormat.parse(string);
    return outputFormat.format(dateTime);
  }
}
