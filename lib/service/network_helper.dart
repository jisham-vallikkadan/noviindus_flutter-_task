import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../utils/shared_preference.dart';
import '../utils/toast_util.dart';

class NetworkHelper {
  Future<http.Response?> getRequest({
    required BuildContext context,
    required String url,
    Map<String, String>? header,
  }) async {
    http.Response? response;
    try {
      HashMap<String, String> headers = HashMap();
      late String token;

      final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);

      if (hasToken) {
        token = await SharedPrefUtil.getString(keyAccessToken);
      } else {
        token = "";
      }
      response = await http.get(
        Uri.parse(url),
        headers: header ??
            {
              'Content-Type': 'application/json',
              "Authorization": "Bearer $token"
            },
      );
      debugPrint("$url---$headers-->${response.body}======");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    return response;
  }

  Future<http.Response?> postRequest({
    String? url,
    var body,
    Map<String, String>? header,
  }) async {
    late String token;

    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);

    if (hasToken) {
      token = await SharedPrefUtil.getString(keyAccessToken);
    } else {
      token = "";
    }
    Map<String, String> headers = {
      // 'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse(url!),
        body: body,
        headers: header ?? headers,
      );
      debugPrint(
          "$url --- status:${response.statusCode}---body:${response.body}------------$headers--------$body");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    return response;
  }
}
