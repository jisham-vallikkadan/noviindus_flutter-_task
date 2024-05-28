import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus_machine_test/presentation/screens/spalsh_screen.dart';
import 'package:noviindus_machine_test/provider/Patient_provider.dart';
import 'package:noviindus_machine_test/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider<PatientProvider>(
                  create: (_) => PatientProvider()),
              ChangeNotifierProvider<AuthProvider>(
                  create: (_) => AuthProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
            )));
  }
}
