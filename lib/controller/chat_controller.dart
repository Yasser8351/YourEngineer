import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/utils.dart';
import 'package:your_engineer/app_config/app_config.dart';
// import 'package:get/get.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';

import '../app_config/api_url.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/chat_models/last_chats_model.dart';
import '../sharedpref/user_share_pref.dart';

class ChatController extends GetxController {
  final SharedPrefUser _pref = SharedPrefUser();
  var loadingState = LoadingState.initial.obs;
  var loadingStateChat = LoadingState.initial.obs;
  String userId = '2f8fd23e-d3fc-43a6-b111-2678b065d2c0';
  String email = '';

  List<Chats> lastChatsList = [];
  List<ChatBetweenUsers> listChatBetweenUsers = [];

  @override
  onInit() {
    getLastchats();
    super.onInit();
  }

  getUserId() async {
    myLog("email", email);
    email = await _pref.getEmail();
    update();
    myLog("email", email);
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
    } on DioError catch (error) {
      // error.response.data[""];
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

  Future<void> getChatBetweenUsers({required String receiver_id}) async {
    loadingState(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      final data = {
        "receiver_id": receiver_id,
      };

      myLog("start methode \n $receiver_id", "getChatBetweenUsers");

      var response = await Dio()
          .post(
            ApiUrl.getChatBetweenUsers(page: 1, size: 20),
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode} ");
      myLog("response data", "${response.data}");

      if (response.statusCode == 200) {
        var chatBetweenUsersModel =
            ChatBetweenUsersModel.fromJson(response.data);

        listChatBetweenUsers = chatBetweenUsersModel.results!;
        // listChatBetweenUsers = chatBetweenUsersModel.results!.reversed.toList();

        loadingState(LoadingState.loaded);

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } catch (error) {
      if (error is DioError) {
        error.response!.data['msg'];
      }

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

  Future<void> createChat(
      {required String message, required String receiver_id}) async {
    loadingStateChat(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      FormData data = FormData.fromMap({
        "receiver_id": receiver_id,
        "message": message,
        "message_type": "text",
        "attachment": ""
        // "attachment": await MultipartFile.fromFile(
        //   imageId.path,
        //   contentType: MediaType("image", "${imageId.path.split(".").last}"
        // ),
        // ),
      });

      myLog("start methode", "createChat");

      var response = await Dio()
          .post(
            ApiUrl.createChat,
            data: data,
            options: Options(
              headers: ApiUrl.getHeaderImage(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response.statusCode methode", "${response.statusCode} ");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // var chatBetweenUsersModel =
        //     ChatBetweenUsersModel.fromJson(response.data);

        // listChatBetweenUsers = chatBetweenUsersModel.results!;

        loadingStateChat(LoadingState.loaded);

        update();
      } else {
        var msg = jsonEncode(response.data);

        Get.defaultDialog(title: msg.toString());
        loadingStateChat(LoadingState.error);
      }
    } catch (error) {
      if (error is DioError) {
        Get.defaultDialog(title: '', middleText: error.response!.data['msg']);

        myLog("response", "${error.response!.data['msg']} ");
      }
      loadingStateChat(LoadingState.error);
      if (error is TimeoutException) {
        Get.defaultDialog(title: AppConfig.timeOut.tr);
      }
      if (error is SocketException) {
        Get.defaultDialog(title: AppConfig.failedInternet.tr);
      } else {
        Get.defaultDialog(title: AppConfig.errorOoccurred.tr);
      }

      myLog("catch createChat", error.toString());
    }
  }
}
