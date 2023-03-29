import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/chat_models/last_chats_model.dart';
import '../sharedpref/user_share_pref.dart';

class ChatController extends GetxController {
  final SharedPrefUser _pref = SharedPrefUser();
  var loadingState = LoadingState.initial.obs;

  List<Chats> lastChatsList = [];

  @override
  onInit() {
    super.onInit();
    getLastchats();
  }

  Future<void> getLastchats() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      myLog("start methode", "getLastchats");

      var response = await Dio()
          .post(
            ApiUrl.getLastchats(page: 1, size: 10, search: ''),
            options: Options(
              headers: ApiUrl.getHeader2(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode}");
      myLog("response data", "${response.data}");

      if (response.statusCode == 200) {
        lastChatsList = LastchatsModel.fromJson(response.data).results;
        // final lastchatsModel = lastchatsModelFromJson(response.data);

        loadingState(LoadingState.loaded);

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      loadingState(LoadingState.error);
      if (error is TimeoutException) {
        // Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        // Get.defaultDialog(title: AppConfig.failedInternet.tr);
      } else {
        // Get.defaultDialog(title: AppConfig.errorOoccurred.tr);
      }

      myLog("catch last chat", error.toString());
    }
  }
}
