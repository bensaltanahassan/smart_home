import 'package:flutter/material.dart';
import 'package:smart_home/core/class/statusrequest.dart';
import 'package:smart_home/core/constant/imageassets.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  const HandlingDataView({
    super.key,
    this.statusRequest,
    required this.child,
    this.loadingWidget,
  });
  final StatusRequest? statusRequest;
  final Widget? loadingWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      if (loadingWidget != null) {
        return loadingWidget!;
      }
      return Center(child: Lottie.asset(AppImageAsset.loading));
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Center(child: Lottie.asset(AppImageAsset.offline));
    } else if (statusRequest == StatusRequest.serverfailure) {
      return Center(child: Lottie.asset(AppImageAsset.server));
    } else if (statusRequest == StatusRequest.failure) {
      return Center(child: Lottie.asset(AppImageAsset.nodata));
    } else {
      return child;
    }
  }
}
