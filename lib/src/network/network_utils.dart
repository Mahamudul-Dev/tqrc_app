import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:tqrc_app/routes/routes.dart';
import 'package:tqrc_app/src/network/api.dart';
import 'package:tqrc_app/src/services/enums.dart';
import 'package:tqrc_app/src/services/local_storage.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class Network {
  static var noInternetMessage = "Please check your connection!";

  static getRequest({required String endPoint, params}) async {
    if (!await hasInternet) {
      throw noInternetMessage;
    }

    String tenant = LocalStorage.getData(key: LocalStorageKey.tenant) ?? '';
    String url = '${Api.baseUrl}${tenant.isEmpty ? '' : '$tenant/'}$endPoint';

    kPrint("\nYou hit: $url");
    kPrint("Request Params: $params");

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    http.Response response = await http.get(
      Uri.parse(url).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static postRequest({required String endPoint, body}) async {
    if (!await hasInternet) {
      throw noInternetMessage;
    }

    String tenant = LocalStorage.getData(key: LocalStorageKey.tenant) ?? '';
    String url = '${Api.baseUrl}${tenant.isEmpty ? '' : '$tenant/'}$endPoint';

    kPrint('\nYou hit: $url');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    return response;
  }

  static multipartAddRequest({
    required String endPoint,
    required Map<String, String> body,
    required String fileKeyName,
    required String filePath,
  }) async {
    if (!await hasInternet) {
      throw noInternetMessage;
    }

    String tenant = LocalStorage.getData(key: LocalStorageKey.tenant) ?? '';
    String url = '${Api.baseUrl}${tenant.isEmpty ? '' : '$tenant/'}$endPoint';

    kPrint("\nYou hit: $url");
    kPrint("Request body: $body");

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    http.MultipartRequest request;
    if (filePath.isEmpty || filePath == '') {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(headers);
    } else {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath(fileKeyName, filePath));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static handleResponse(http.Response response) async {
    try {
      if (!await hasInternet) {
        throw noInternetMessage;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        _logout();
        String msg = "Unauthorized";
        if (response.body.isNotEmpty) {
          if(json.decode(response.body)['errors'] != null){
            msg = json.decode(response.body)['errors'];
          }
        }
        throw msg;
      } else if (response.statusCode == 404) {
        throw 'Page Not Found!';
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body)['errors'];
          if(data == null){
            msg = jsonDecode(response.body)['message'] ?? msg;
          }
          else if (data is String) {
            msg = data;
          } else if (data is Map) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException catch (_) {
      throw noInternetMessage;
    } on FormatException catch (_) {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  static void _logout() {
    LocalStorage.removeData(key: LocalStorageKey.token);
    Get.offAllNamed(RouteGenerator.login);
  }
}