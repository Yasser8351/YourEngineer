import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';
import 'package:your_engineer/controller/offers_controller.dart';
import 'package:your_engineer/controller/wallet_controller.dart';

class BinindingApp implements Bindings {
  @override
  void dependencies() {
    Get.put(FaqController());
    Get.lazyPut(() => WalletController(), fenix: true);
    Get.lazyPut(() => OfferController(), fenix: true);
  }
}
