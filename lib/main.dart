import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_home/core/constant/apptheme.dart';
import 'package:smart_home/core/services/services.dart';
import 'package:smart_home/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print the dimension of the screen

    return ScreenUtilInit(
      designSize: const Size(411, 867),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant Mobile',
          getPages: AppRouter.routes,
          theme: AppTheme.themeEnglish,
        );
      },
    );
  }
}
