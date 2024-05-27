import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_home/core/services/services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getBool("login") ?? false) {
      // return const RouteSettings(name: AppRoutes.containerPage);
    }
    if (myServices.sharedPreferences.getBool("intro") ?? false) {
      // return const RouteSettings(name: AppRoutes.welcome);
    }

    return null;
  }
}
