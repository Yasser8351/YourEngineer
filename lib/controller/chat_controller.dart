import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart';
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
  String userId = "";
  String email = '';
  String message = "";
  ScrollController scrollController = ScrollController();

  bool isLoadingMessage = false;
  bool onConnectError = false;

  List<Chats> lastChatsList = [];
  List<ChatBetweenUsers> listChatBetweenUsers = [];
  late IO.Socket socket;

  //////
  final ImagePicker _picker = ImagePicker();
  File? imageMessage;

  @override
  onInit() {
    getLastchats();
    getEmail();
    getUserId();
    super.onInit();
  }

  getEmail() async {
    email = await _pref.getEmail();
    update();
    myLog("email", email);
  }

  isLoadin() {
    isLoadingMessage = !isLoadingMessage;
    update();
  }

  getUserId() async {
    userId = await _pref.getId();
    update();
    myLog("getUserId", userId);
  }

  Future<void> getLastchats() async {
    loadingState(LoadingState.loading);

    myLog("start methode", "getLastchats");
    try {
      var token = await _pref.getToken();

      var response = await Dio()
          .post(
            ApiUrl.getLastchats(page: 1, size: 20, search: ''),
            options: Options(
              headers: ApiUrl.getHeader2(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      print("${response}");
      myLog("response.statusCode methode", "${response}");
      myLog("response data", "${response.data}");

      if (response.statusCode == 200) {
        lastChatsList = LastchatsModel.fromJson(response.data).results;

        if (lastChatsList.length == 0) {
          loadingState(LoadingState.noDataFound);
        } else {
          loadingState(LoadingState.loaded);
        }

        update();
      } else {
        loadingState(LoadingState.error);
      }
    } on DioError catch (error) {
      message = error.response!.data['msg'] ?? "";

      // error.response.data[""];
      loadingState(LoadingState.error);
      if (error is TimeoutException) {
        message = AppConfig.timeOut.tr;
      }
      if (error is SocketException) {
        message = AppConfig.failedInternet.tr;
      } else {
        // message = AppConfig.errorOoccurred.tr;
        message = error.response!.data['msg'] ?? "";
      }

      myLog("catch last chat", error.toString());
      update();
    }
    update();
  }

  Future<void> getChatBetweenUsers({required String receiver_id}) async {
    loadingState(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      final data = {
        "receiver_id": receiver_id,
      };

      myLog("start methode getChatBetweenUsers \n ", "$receiver_id");

      var response = await Dio()
          .post(
            ApiUrl.getChatBetweenUsers(page: 1, size: 20),
            data: data,
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      if (response.statusCode == 200) {
        var chatBetweenUsersModel =
            ChatBetweenUsersModel.fromJson(response.data);

        // listChatBetweenUsers = chatBetweenUsersModel.results!;
        listChatBetweenUsers = chatBetweenUsersModel.results!.reversed.toList();

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

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent * 2,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    update();
  }

  Future<void> createChat(
      {required String message, required String receiver_id}) async {
    loadingStateChat(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      myLog("receiver_id", receiver_id);

      FormData data = FormData.fromMap({
        "receiver_id": receiver_id,
        "message": message.isEmpty ? "image" : message,
        "message_type": imageMessage == null ? "message" : "file",
        "attachment": imageMessage == null
            ? ""
            : await MultipartFile.fromFile(
                imageMessage!.path,
                contentType:
                    MediaType("image", "${imageMessage!.path.split(".").last}"),
              ),
        // "attachment": await MultipartFile.fromFile(
        //   imageMessage.path,
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
        clearImageMessage();
        listChatBetweenUsers.add(ChatBetweenUsers.fromJson3(response.data));

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

  Future<ChatBetweenUsers?> addCreateChat(
      {required String message, required String receiver_id}) async {
    loadingStateChat(LoadingState.loading);

    try {
      var token = await _pref.getToken();

      myLog("receiver_id", receiver_id);

      FormData data = FormData.fromMap({
        "receiver_id": receiver_id,
        "message": message.isEmpty ? "image" : message,
        "message_type": imageMessage == null ? "message" : "file",
        "attachment": imageMessage == null
            ? ""
            : await MultipartFile.fromFile(
                imageMessage!.path,
                contentType:
                    MediaType("image", "${imageMessage!.path.split(".").last}"),
              ),
        // "attachment": await MultipartFile.fromFile(
        //   imageMessage.path,
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
        clearImageMessage();
        listChatBetweenUsers.add(ChatBetweenUsers.fromJson3(response.data));

        loadingStateChat(LoadingState.loaded);

        update();
        return ChatBetweenUsers.fromJson3(response.data);
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
    return null;
  }

  Future<void> getImageFromGallery() async {
    /// get Image User Profile From Gallery
    final imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imageFile == null) {
      return;
    }
    imageMessage = File(imageFile.path);
    update();
  }

  clearImageMessage() {
    imageMessage = null;
    update();
  }

  ////////////////////////////////// chat methode helper ////////////////////////////
  connectSocket() async {
    try {
      socket = IO.io(
          'http://62.171.175.75:84',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders(
                  {'Connection': 'upgrade', 'Upgrade': 'websocket'})
              .build());
      socket.connect();
      socket.onConnect((data) {
        myLog('onConnect', socket.connected);
      });
      socket.emit('addUser', email);
      socket.on('getMessage', handleMessage);
      socket.onDisconnect((data) => {
            myLog("message", data),
            update(),
          });
      socket.onConnectError((data) => {
            onConnectError = true,
            myLog("onConnectError", data),
            update(),
          });
      socket.on('fromServer', (_) => myLog("fromServer", '_'));
    } catch (e) {
      myLog('catch error', e.toString());
    }
  }

  handleMessage(dynamic data) {
    myLog('', " * getMessage");
    var d = data as Map<String, dynamic>;
    myLog(data.toString(), " * getMessage");
    listChatBetweenUsers.add(ChatBetweenUsers.fromJson2(d));

    // if (this.mounted) {
    //   setState(() {
    //     myLog('', " * setstate");
    //   });
    // }
  }
}
