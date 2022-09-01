import 'package:flutter/material.dart';
import 'package:logo/controllers/auth_controller.dart';
import 'package:logo/views/pages/splash_Screen.dart';
import 'package:get/get.dart';
import 'package:logo/constants/firebase.dart';

import 'controllers/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => AppController(), fenix: true);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
