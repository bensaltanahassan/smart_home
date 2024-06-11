import 'package:get/get.dart';
import 'package:smart_home/core/constant/routes.dart';
import 'package:smart_home/core/middleware/mymiddleware.dart';
import 'package:smart_home/view/pages/home/home_page.dart';
import 'package:smart_home/view/pages/login/login.page.dart';

class AppRouter {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: '/',
      page: () => const LoginPage(),
      middlewares: [MyMiddleWare()],
    ),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
  ];
}
