import 'package:get/get.dart';

import '../screen/project/offer_screen.dart';

class ListProjectController extends GetxController {
  goToOfferScreen(int index, List<dynamic> results) {
    Get.to(OffersScreen(), arguments: {'index': index, 'results': results});
  }
}
