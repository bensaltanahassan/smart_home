import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/core/constant/routes.dart';
import 'package:smart_home/core/functions/showsnackbar.dart';
import 'package:smart_home/core/services/services.dart';
import 'package:smart_home/data/services/auth.services.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isLoading = false;
  bool showPassword = false;
  final authServices = AuthServices();
  Future<void> login() async {
    isLoading = true;
    update(["loginButton"]);
    final result =
        await authServices.login(emailController.text, passwordController.text);
    if (result) {
      await Get.find<MyServices>().sharedPreferences.setBool("isLogged", true);
      await Get.offAndToNamed(AppRoutes.home);
    } else {
      showCustomSnackBar(title: "Error", message: "Email Or Password Wrong");
    }
    isLoading = false;
    update(["loginButton"]);
  }

  void showPasswordToggle() {
    showPassword = !showPassword;
    update(["showPassword"]);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
