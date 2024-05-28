import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../model/login_model.dart';
import '../utils/toast_util.dart';
import '../utils/urls.dart';
import 'network_helper.dart';

class AuthService {
  Future<LoginModel?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var response;
    response = await NetworkHelper().postRequest(
        url: Urls.loginUrl, body: {"username": email, "password": password});
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      var error = jsonDecode(response.request);
      print(error.toString());
      ToastUtil.show(error['message']);
      debugPrint(response.body);
      return null;
    }
  }

  Future register({
    required BuildContext context,
    String? name,
    String? payment,
    String? phone,
    String? address,
    String? totalamount,
    String? discountamount,
    String? advanceamount,
    String? balanceamount,
    String? datendtime,
    String? male,
    String? female,
    String? treatments,
    String? branch,
  }) async {
    var response;
    response = await NetworkHelper().postRequest(url: Urls.registerUrl, body: {
      "name": name,
      "excecutive": "Test",
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": totalamount,
      "discount_amount": discountamount,
      "advance_amount": advanceamount,
      "balance_amount": balanceamount,
      "date_nd_time": datendtime,
      "id": '',
      "male": male,
      "female": female,
      "branch": branch,
      "treatments": treatments,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      var error = jsonDecode(response.request);
      print(error.toString());
      ToastUtil.show(error['message']);
      debugPrint(response.body);
      return null;
    }
  }
}
