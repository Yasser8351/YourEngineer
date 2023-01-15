import 'package:get/get.dart';
import 'package:your_engineer/controller/populer_services_controller.dart';
import 'package:your_engineer/controller/project_controller.dart';
import 'package:your_engineer/controller/top_engineer_controller.dart';

import '../controller/setting_controller.dart';

class BinindingApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => PopulerServicesController()), fenix: true);
    Get.lazyPut((() => TopEngineerController()), fenix: true);
    Get.lazyPut((() => ProjectController()), fenix: true);
    Get.put(SettingControoler());
  }
}
