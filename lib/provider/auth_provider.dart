import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/presentation/screens/Patient_list_screen/Patient_list.dart';
import 'package:noviindus_machine_test/service/auth_service.dart';
import 'package:noviindus_machine_test/utils/constants.dart';

import '../model/login_model.dart';
import '../service/network_helper.dart';
import '../utils/shared_preference.dart';
import '../utils/toast_util.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  LoginModel? loginData;

  login({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    isLoading = true;
    notifyListeners();
    loginData = await AuthService()
        .login(context: context, password: password, email: email);
    print('[------${jsonEncode(loginData)}');
    if (loginData?.status == true) {
      await SharedPrefUtil.writeString(
          keyAccessToken, loginData!.token.toString());
      ToastUtil.show(loginData!.message.toString());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const PatientListScreen()));
    } else {
      ToastUtil.show(loginData!.message.toString());
    }
    isLoading = false;
    notifyListeners();
  }


}
