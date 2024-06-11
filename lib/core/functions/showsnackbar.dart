import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/core/constant/colors.dart';

void showCustomSnackBar({
  required String title,
  required String message,
}) {
  Get.showSnackbar(
    GetSnackBar(
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.all(10),
      maxWidth: Get.width - 20,
      borderRadius: 4,
      animationDuration: const Duration(seconds: 2),
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      // backgroundColor: AppColors.packetColor4,
      backgroundGradient: LinearGradient(
        colors: [
          AppColors.secondColor.withOpacity(.8),
          AppColors.secondColor,
        ],
      ),
    ),
  );
}
