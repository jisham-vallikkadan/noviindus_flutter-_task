import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: ScreenUtil().screenHeight - ScreenUtil().statusBarHeight,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: ScreenUtil().screenWidth,
                      height: 200.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/login_image.png',
                              ),
                              fit: BoxFit.fill)),
                      child: Center(
                        child: Image.asset(
                          'assets/images/splash_icon.png',
                          width: 80.w,
                          height: 80.w,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login or register to book your appointments",
                            style: TextStyle(
                              color: const Color(0xFF1C1C1C),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 39.h,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              color: const Color(0xFF404040),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomTextField(
                            // controller: TextEditingController(),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter email ";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Enter your email",
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              color: const Color(0xFF404040),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomTextField(
                            hintText: "Enter password",
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Password ";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: "Login",
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                print('sucess');
                              } else {
                                print('qqqq');
                              }
                            },
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  'By creating or logging into an account you are agreeing with ou',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.sp),
                              children: [
                                TextSpan(
                                  text: ' Terms and Conditions ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Colors.blue),
                                ),
                                const TextSpan(
                                  text: 'And',
                                ),
                                TextSpan(
                                  text: ' Privacy Policy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
