import 'package:get/get.dart';
import 'package:your_engineer/controller/populer_services_controller.dart';

class BinindingApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => PopulerServicesController()), fenix: true);
  }
}
