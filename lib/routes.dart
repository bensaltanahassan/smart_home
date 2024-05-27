import 'package:get/get.dart';
import 'package:smart_home/core/constant/routes.dart';
import 'package:smart_home/view/pages/login/login.page.dart';

class AppRouter {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      // middlewares: [MyMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const LoginPage(),
      // middlewares: [MyMiddleWare()],
    ),
  ];
}
