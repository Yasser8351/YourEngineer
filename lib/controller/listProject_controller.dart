import 'package:get/get.dart';

import '../screen/project/offer_screen.dart';

class ListProjectController extends GetxController {
  goToOfferScreen(dynamic results) {
    Get.to(() => OffersScreen(), arguments: {'results': results});
  }
}
