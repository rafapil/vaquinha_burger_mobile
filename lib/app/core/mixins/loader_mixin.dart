import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(RxBool loading) {
    ever(
      loading,
      (_) async {
        if (loading.isTrue) {
          await Get.dialog(
            WillPopScope(
              onWillPop: () async => false,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            barrierDismissible: false,
          );
        } else {
          Get.back();
        }
      },
    );
  }
}
