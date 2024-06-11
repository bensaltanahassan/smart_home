import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_home/controllers/home/home.controller.dart';
import 'package:smart_home/core/constant/colors.dart';
import 'package:smart_home/data/model/composent.model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backGroundColor,
            AppColors.color1,
            AppColors.color2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.3, 0.8],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "ProHome",
            style: TextStyle(color: AppColors.secondColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.secondColor),
              onPressed: () {
                controller.signOut();
              },
            ),
          ],
        ),
        body: OfflineBuilder(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (!connected) {
              controller.signOut();
            }
            return SafeArea(
              child: GetBuilder<HomeController>(builder: (controller) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15).r,
                  children: [
                    const CustomTitle(title: "Home Automation"),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomGridElementWithSwitch(
                            composent: controller.ledComposent,
                            onChanged: (value) {
                              controller.switchLed();
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: CustomGridElementWithSwitch(
                            composent: controller.doorComposent,
                            onChanged: (value) {
                              if (value) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Entrer le code pin"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Pinput(
                                            autofocus: true,
                                            closeKeyboardWhenCompleted: false,
                                            controller:
                                                controller.pinController,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (await controller
                                                  .validateDoorPin(controller
                                                      .pinController.text)) {
                                                controller.switchDoor();
                                                Get.back();
                                              } else {
                                                Get.snackbar(
                                                  "Erreur",
                                                  "Code pin incorrect",
                                                  backgroundColor:
                                                      AppColors.backGroundColor,
                                                  colorText:
                                                      AppColors.secondColor,
                                                );
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondColor,
                                                borderRadius:
                                                    BorderRadius.circular(10).r,
                                              ),
                                              height: 60.h,
                                              width: double.infinity,
                                              child: Center(
                                                child: Text(
                                                  "Ouvrir la porte",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).then((value) {
                                  controller.pinController.clear();
                                });
                              } else {
                                controller.switchDoor();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomGridElementWithoutSwitch(
                            composent: controller.roomComposent,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: CustomGridElementWithoutSwitch(
                              composent: controller.earthQuakeComposent),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomGridElementWithoutSwitch(
                      composent: controller.fireComposent,
                      
                    ),
                    SizedBox(height: 10.h),
                    const CustomTitle(title: "Arrosage automatique"),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                            child: CustomGridElementWithoutSwitch(
                                composent: controller.solComposent)),
                        SizedBox(width: 20.w),
                        Expanded(
                            child: CustomGridElementWithSwitch(
                          composent: controller.pumpComposent,
                          onChanged: (value) {
                            controller.switchPump();
                          },
                        )),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const CustomTitle(title: "DHT"),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                            child: CustomGridElementWithoutSwitch(
                          composent: controller.temComposent,
                        )),
                        SizedBox(width: 20.w),
                        Expanded(
                            child: CustomGridElementWithoutSwitch(
                          composent: controller.humComposent,
                        )),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomGridElementWithSwitch(
                      composent: controller.fanComposent,
                      onChanged: (value) {
                        controller.switchFan();
                      },
                    ),
                    SizedBox(height: 20.h),
                    // const CustomGridElement(isActivated: true),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.secondColor,
      ),
    );
  }
}

class CustomGridElementWithSwitch extends StatelessWidget {
  const CustomGridElementWithSwitch({
    super.key,
    required this.composent,
    this.onChanged,
  });

  final ComposentModel composent;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      padding: const EdgeInsets.symmetric(vertical: 8).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey, width: 0.2),
        gradient: composent.isActivated!
            ? LinearGradient(
                colors: [
                  Colors.blue[800]!,
                  Colors.blue[600]!,
                  Colors.blue[400]!,
                  Colors.blue[200]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  AppColors.backGroundColor,
                  AppColors.color1,
                  AppColors.color2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                composent.isActivated! ? "ON" : "OFF",
                style: TextStyle(
                  color: composent.isActivated! ? Colors.white : Colors.grey,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                inactiveTrackColor: Colors.grey,
                activeTrackColor: Colors.white,
                activeColor: Colors.blue,
                value: composent.isActivated!,
                onChanged: onChanged,
              ),
            ],
          ),
          if (composent.lottie != null)
            Lottie.asset(
              composent.lottie!,
              height: 70.r,
              width: 70.r,
              animate: composent.isActivated,
            ),
          if (composent.icon != null)
            SvgPicture.asset(composent.icon!, height: 70.r),
          Text(
            composent.title!,
            style: TextStyle(
              color: composent.isActivated! ? Colors.white : Colors.grey,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            composent.subtitle!,
            style: TextStyle(
              color: composent.isActivated! ? Colors.white : Colors.grey,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomGridElementWithoutSwitch extends StatelessWidget {
  const CustomGridElementWithoutSwitch({
    super.key,
    required this.composent,
  });

  final ComposentModel composent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      padding: const EdgeInsets.symmetric(vertical: 8).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey, width: 0.2),
        gradient: composent.isActivated!
            ? LinearGradient(
                colors: [
                  Colors.blue[800]!,
                  Colors.blue[600]!,
                  Colors.blue[400]!,
                  Colors.blue[200]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  AppColors.backGroundColor,
                  AppColors.color1,
                  AppColors.color2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(composent.title!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: composent.isActivated! ? Colors.white : Colors.grey,
              )),
          if (composent.icon != null)
            SvgPicture.asset(composent.icon!, height: 70.r),
          if (composent.lottie != null)
            Lottie.asset(
              composent.lottie!,
              height: 70.r,
              width: 70.r,
              animate: composent.isActivated,
            ),
          SizedBox(height: 10.h),
          Text(
            composent.value!,
            style: TextStyle(
              color: composent.isActivated! ? Colors.white : Colors.grey,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
