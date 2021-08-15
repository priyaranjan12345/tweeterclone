import 'package:get/get.dart';
import 'package:twitterclone/controller/mycontroller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      MyController(),
    );
  }
}
