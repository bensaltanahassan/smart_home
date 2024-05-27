import 'package:get/get.dart';

class LoginController extends GetxController {
  bool? isLoading = false;
  bool showPassword = false;
  Future<void> login() async {
    isLoading = true;
    update(["loginButton"]);
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    update(["loginButton"]);
  }

  void showPasswordToggle() {
    showPassword = !showPassword;
    update(["showPassword"]);
  }
}
