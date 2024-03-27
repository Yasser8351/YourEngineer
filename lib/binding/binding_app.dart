import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';

class BinindingApp implements Bindings {
  @override
  void dependencies() {
    Get.put(FaqController());
    // Get.put(TopEngineerController());
    // Get.put(ProjectControllerHome());
    // Get.put(SettingControoler());
  }
}
