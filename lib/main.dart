import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'routers/router.dart';

void main() async {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812 - 44),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context) => GetMaterialApp(
        initialRoute: '/',
        getPages: router,
        builder: EasyLoading.init(),
      ),
    );
  }
}
