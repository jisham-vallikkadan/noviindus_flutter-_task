import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus_machine_test/presentation/screens/Patient_list_screen/Patient_list.dart';
import 'package:noviindus_machine_test/presentation/screens/login_screen/login_screen.dart';

import '../../utils/constants.dart';
import '../../utils/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
     loadData();
    });
  }

  loadData()async{


    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);

    if (hasToken) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PatientListScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash_image.png',
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        fit: BoxFit.fill,
      ),
    );
  }
}
