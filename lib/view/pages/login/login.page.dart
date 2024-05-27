import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_home/controllers/login/login.controller.dart';
import 'package:smart_home/core/constant/colors.dart';
import 'package:smart_home/core/constant/imageassets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      bottomNavigationBar: GetBuilder<LoginController>(
          id: "loginButton",
          builder: (controller) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: controller.isLoading == true
                  ? Container(
                      margin: const EdgeInsets.all(20),
                      height: 60.h,
                      width: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.login();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.secondColor,
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        // login button
                        height: 60.h,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            );
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppImageAsset.logo,
                width: 200.w,
                height: 200.h,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome to Smart Home",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Email",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10).r,
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Password",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            GetBuilder<LoginController>(
                id: "showPassword",
                builder: (controller) {
                  return TextFormField(
                    obscureText: Get.find<LoginController>().showPassword,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.showPasswordToggle();
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: controller.showPassword == true
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.visibility_off,
                                  color: Colors.white),
                        ),
                      ),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10).r,
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
